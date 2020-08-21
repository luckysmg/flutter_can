import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/net/error_handle.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/user_profile_util.dart';

import 'api.dart';
import 'intercept.dart';

///
/// @created by 文景睿
/// description:网络请求封装
///
class DioUtil {
  static DioUtil _dioUtil;
  static Dio dio;

  static DioUtil getInstance() {
    if (_dioUtil == null) {
      _dioUtil = DioUtil._();
    }
    return _dioUtil;
  }

  DioUtil._() {
    var options = BaseOptions(
      connectTimeout: 6000,
      receiveTimeout: 6000,
      responseType: ResponseType.plain,
      validateStatus: (status) {
        return true;
      },
      baseUrl: API.BASE_URL,
    );

    dio = Dio(options);
    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(TokenInterceptor());
  }

  ///post请求
  ///T 实体的类型，必传，生成的entity需要在EntityFactory封装
  Future<void> doPost<T>(
      {@required String url,
      @required BuildContext context,
      @required Function(T t) onSuccess,
      dynamic param,
      Function(NetError e) onFailure,
      String contentType = API.NORMAL_CONTENT_TYPE,
      bool useHeader = true,
      int delayMills = Constants.delayInit,
      bool needDelay = false}) async {
    if (needDelay) {
      await Future.delayed(Duration(milliseconds: delayMills));
    }
    int code;
    String msg;
    if (useHeader) {
      dio.options.headers['Content-Type'] = contentType;
    }
    try {
      var resp = await dio.post(url, data: param);
      Map map = _parseData(resp.data);
      code = map['code'];
      msg = map['message'];
      if (code == 0 || code == null) {
        try {
          T t = JsonConvert.fromJsonAsT<T>(map);
          onSuccess(t);
          if (!Constants.inRelease) {
            print(map.toString());
          }
          return;
        } catch (e) {
          print(e.toString());
        }
      } else if (code == -1) {
        if (!Constants.inRelease) {
          print('错误1');
          print('http状态码 ${resp.statusCode}');
          print('错误接口：$url');
          print('错误code：$code');
          print('错误原因：${msg ?? ''}');
        }
        if (onFailure != null) onFailure(NetError(-1, msg));
      } else if (code == 10003) {
        ///accessToken过期
        ///重新请求
        print('重新请求接口');
        doPost(
            url: url,
            context: context,
            onSuccess: onSuccess,
            onFailure: onFailure,
            param: param,
            contentType: contentType,
            useHeader: useHeader,
            needDelay: needDelay,
            delayMills: delayMills);
      } else if (code == 10004 || code == 10000 || code == 10006) {
        ///跳转登陆页面
        if (!GlobalStore.isShowingLoginPage) {
          GlobalStore.isShowingLoginPage = true;
          UserProfileUtil.userLogOut();
          UserProfileUtil.pushLoginPage(context);
        }

        if (!Constants.inRelease) {
          print('错误2');
          print('错误接口：$url');
          print('错误原因：登陆过期');
        }
        if (onFailure != null) onFailure(NetError(code, msg));
      } else {
        if (!Constants.inRelease) {
          print('错误3');
          print('错误接口：$url');
          print('错误code：$code');
          print('错误原因：${msg ?? ''}');
        }
        if (onFailure != null) onFailure(NetError(code, msg));
      }
    } on DioError catch (e) {
      if (!Constants.inRelease) {
        print('错误4');
        print('错误接口：$url');
        print('错误原因：${e.message}');
      }

      if (onFailure != null) {
        if (e.error is SocketException) {
          onFailure(NetError(-1, '网络连接异常', networkError: true));
        } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          onFailure(NetError(-1, '连接超时', networkError: true));
        } else if (e.error is HttpException) {
          onFailure(
            NetError(-200, '网络错误', networkError: true),
          );
        } else {
          onFailure(
            NetError(-200, '服务器繁忙，请稍后再试!', networkError: true),
          );
        }
      }
    }
  }

  Dio getDio() {
    return dio;
  }

  Map<String, dynamic> _parseData(String data) {
    return json.decode(data);
  }
}

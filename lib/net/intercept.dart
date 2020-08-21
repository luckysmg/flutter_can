import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/user_profile_util.dart';

import 'dio_util.dart';
import 'error_handle.dart';

///
/// @created by 文景睿
/// description:拦截器
///
class AuthInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) {
    String accessToken = UserProfileUtil.getAccessToken();
    options.headers["Cookie"] = "UCA=$accessToken";
    return super.onRequest(options);
  }
}

class TokenInterceptor extends Interceptor {
  bool locked = false;

  Future<String> getToken() async {
    Map<String, String> params = Map();
    params["refreshToken"] = SpUtil.getString(Constants.refreshToken);
    try {
      _tokenDio.options = DioUtil.getInstance().getDio().options;
      var response = await _tokenDio.post("/asf/usercenter/user/token/exchange",
          data: params);
      if (response.statusCode == ExceptionHandle.success) {
        return json.decode(response.data.toString())["accessToken"];
      }
    } catch (e) {
      print('刷新token失败');
    }
    return null;
  }

  Dio _tokenDio = Dio();

  @override
  onResponse(Response response) async {
    var code = json.decode(response.toString())["code"];
    if (response != null && code == ExceptionHandle.accessToken_error) {
      String accessToken;
      if (!locked) {
        print("-----------自动刷新Token------------");
        locked = true;
        Dio dio = DioUtil.getInstance().getDio();
        dio.lock();
        accessToken = await getToken(); // 获取新的accessToken
        print("-----------NewToken: $accessToken ------------");
        SpUtil.putString(Constants.accessToken, accessToken);
        dio.unlock();
        locked = false;
      } else {
        if (accessToken != null) {
          {
            ///重新请求失败接口
            var request = response.request;
            request.headers["Cookie"] = "UCA=$accessToken";
            try {
              print("----------- 重新请求接口 ------------");

              ///避免重复执行拦截器，使用tokenDio
              var response = await _tokenDio.request(request.path,
                  data: request.data,
                  queryParameters: request.queryParameters,
                  cancelToken: request.cancelToken,
                  options: request,
                  onReceiveProgress: request.onReceiveProgress);
              return response;
            } on DioError catch (e) {
              return e;
            }
          }
        }
      }
    }
    return super.onResponse(response);
  }
}

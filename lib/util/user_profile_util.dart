import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/entity/user_profile_entity.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/view/login/password_login_page/page.dart';

import 'constants.dart';
import 'navigatior_util.dart';

///
/// @created by luckysmg
/// description:统一的用户数据管理工具类
///
class UserProfileUtil {
  UserProfileUtil._();

  ///判断用户是否登录
  static bool isUserLogin() {
    var accessToken =
        SpUtil.getString(Constants.accessToken, defValue: Constants.INVALID);
    var refreshToken =
        SpUtil.getString(Constants.refreshToken, defValue: Constants.INVALID);
    if (accessToken == Constants.INVALID || refreshToken == Constants.INVALID) {
      return false;
    } else {
      var currentTimeInMs = DateTime.now().millisecondsSinceEpoch;
      var validTime =
          SpUtil.getInt(Constants.refreshTokenValidTime, defValue: 0);

      if (currentTimeInMs > validTime) {
        userLogOut();
        return false;
      }
      return true;
    }
  }

  ///将用户状态设置为登陆，也就是用户登陆成功后立马调用这个就行
  static Future<void> setUserHasLogin(
      {@required String accessToken,
      @required String refreshToken,
      @required int validTime}) async {
    await SpUtil.putString(Constants.accessToken, accessToken);
    await SpUtil.putString(Constants.refreshToken, refreshToken);
    await SpUtil.putInt(Constants.refreshTokenValidTime, validTime);
  }

  ///用户登出,直接调用这个方法
  static void userLogOut() {
    SpUtil.clear();
    SpUtil.putBool(Constants.NEED_SHOW_GUIDE, false);
    GlobalStore.getEventBus().fire(UserInfoChangeEvent(isLogin: false));
  }

  ///获取accessToken
  static String getAccessToken() {
    return SpUtil.getString(Constants.accessToken);
  }

  ///获取refreshToken
  static String getRefreshToken() {
    return SpUtil.getString(Constants.refreshToken);
  }

  ///在查询用户信息的接口数据返回完毕并且用json解析后,记住是在解析后，传入即可
  static Future setUserDetailInfo(UserProfileEntity entity) async {
    await SpUtil.putObject(Constants.userDetailInfo, entity);
  }

  ///拿到缓存的UserDetailInfo
  static UserProfileEntity getUserDetailInfo() {
    UserProfileEntity entity;
    if (isUserLogin()) {
      SpUtil.getObj(Constants.userDetailInfo, (map) {
        entity = JsonConvert.fromJsonAsT(map);
      });
      return entity;
    } else {
      return UserProfileEntity();
    }
  }

  static pushLoginPage(BuildContext context) {
    UserProfileUtil.userLogOut();
    NavigatorUtil.push(context, LoginPage().buildPage(null),
        rootNavigator: true);
  }
}

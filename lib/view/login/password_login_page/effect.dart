import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:neng/entity/login_entity.dart';
import 'package:neng/entity/user_profile_entity.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/dialog_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/util/user_profile_util.dart';

import 'action.dart';
import 'state.dart';

Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    LoginAction.requestLogin: _requestLogin,
    LoginAction.requestUserProfileInfo: _requestUserProfileInfo,
  });
}

void _init(Action action, Context<LoginState> ctx) {
  ctx.state.accountController.addListener(() {
    _verify(ctx);
  });
  ctx.state.passwordController.addListener(() {
    _verify(ctx);
  });
}

///请求登陆
void _requestLogin(Action action, Context<LoginState> ctx) async {
  if (ctx.state.accountController.text.length != 11) {
    TipUtil.show(
        context: ctx.context,
        message: '请输入正确手机号',
        imgPath: Constants.TIP_WARNING);
    return;
  }

  DialogUtil.showLoadingDialog(context: ctx.context);
  DioUtil.getInstance().doPost<LoginEntity>(
      url: API.password_login,
      context: ctx.context,
      param: {
        'mobile': ctx.state.accountController.text,
        'loginPass': ctx.state.passwordController.text
      },
      onSuccess: (data) async {
        ///请求成功，继续请求用户的详细数据
        await UserProfileUtil.setUserHasLogin(
            accessToken: data.accessToken,
            refreshToken: data.refreshToken,
            validTime: data.refreshTime);
        ctx.dispatch(LoginActionCreator.requestUserProfileInfo());
      },
      onFailure: (e) {
        DialogUtil.closeLoadingDialog(ctx.context);
        ToastUtil.show(e.msg);
      });
}

///请求用户的详细并且数据存入缓存
void _requestUserProfileInfo(Action action, Context<LoginState> ctx) {
  DioUtil.getInstance().doPost<UserProfileEntity>(
      url: API.user_profile,
      context: ctx.context,
      onSuccess: (data) async {
        await UserProfileUtil.setUserDetailInfo(data);
        GlobalStore.getEventBus().fire(UserInfoChangeEvent());
        DialogUtil.closeLoadingDialog(ctx.context);
        ctx.state.passwordFocusNode.unfocus();
        ctx.state.accountFocusNode.unfocus();
        Navigator.pop(ctx.context);
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

void _dispose(Action action, Context<LoginState> ctx) {
  GlobalStore.isShowingLoginPage = false;
  ctx.state.accountController.dispose();
  ctx.state.passwordController.dispose();
}

///监听并且更新登陆的button状态
void _verify(Context<LoginState> ctx) {
  String name = ctx.state.accountController.text;
  String password = ctx.state.passwordController.text;
  bool isClick = true;
  bool showClearIcon = false;
  if (name.isEmpty || name.length < 11) {
    isClick = false;
  }
  if (password.isEmpty || password.length < 6) {
    isClick = false;
  }
  if (password.isNotEmpty) {
    showClearIcon = true;
  } else {
    showClearIcon = false;
  }

  if (isClick != ctx.state.canClickButton ||
      showClearIcon != ctx.state.showClearIcon) {
    Map map = Map();
    map['isClick'] = isClick;
    map['showClearIcon'] = showClearIcon;

    ctx.dispatch(LoginActionCreator.updateUI(map));
  }
}

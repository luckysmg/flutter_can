import 'package:fish_redux/fish_redux.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/view/login/password_login_page/page.dart';

import 'action.dart';
import 'state.dart';

Effect<HeaderState> buildEffect() {
  return combineEffects(<Object, Effect<HeaderState>>{
    HeaderAction.action: _onAction,
    HeaderAction.prepareJumpPage: _prepareJumpPage
  });
}

void _onAction(Action action, Context<HeaderState> ctx) {}

void _prepareJumpPage(Action action, Context<HeaderState> ctx) {
  if (UserProfileUtil.isUserLogin()) {
    ///跳转进入用户信息页面
  } else {
    ///跳转进入登陆页
    NavigatorUtil.push(
      ctx.context,
      LoginPage().buildPage(null),
      rootNavigator: true,
    );
  }
}

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/login/find_password_page/page.dart';
import 'package:neng/view/login/register_page/register_page.dart';
import 'package:neng/view/login/verify_code_login_page/page.dart';
import 'package:neng/view/login/widgets/login_button.dart';
import 'package:neng/widgets/back_icon_view.dart';
import 'package:neng/widgets/custuom_text_field.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(LoginState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () {
      state.passwordFocusNode.unfocus();
      state.accountFocusNode.unfocus();
    },
    child: Scaffold(
      backgroundColor: ColorUtil.scaffoldColor,
      resizeToAvoidBottomInset: false,
      appBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: ColorUtil.scaffoldColor,
        automaticallyImplyLeading: false,
        leading: const BackIconView(),
      ),
      body: Column(
        children: <Widget>[
          Text(
            '密码登录',
          )
              .withStyle(
                  fontSize: Constants.titleTextSize,
                  fontWeight: FontWeight.bold)
              .center(),
          Gap.makeGap(height: 40),

          ///手机号输入
          _accountTextField(state, dispatch, viewService),
          Gap.makeGap(height: 20),

          ///密码输入
          _passwordTextField(state, dispatch, viewService),
          Gap.makeGap(height: 20),
          Row(
            children: <Widget>[
              ///验证码登陆
              _buildVerificationCodeLoginText(state, dispatch, viewService),
              const Spacer(),

              ///找回密码
              _buildFindText(state, dispatch, viewService),
            ],
          ).paddingSymmetric(horizontal: 20),

          Gap.makeGap(height: 40),

          ///登陆按钮
          _buildLoginButton(state, dispatch, viewService),
          const Spacer(),
          _buildRegisterText(state, dispatch, viewService),
          Gap.makeGap(height: 40),
        ],
      ).paddingSymmetric(horizontal: 8).withHeight(ScreenUtil.screenHeightDp),
    ),
  );
}

Widget _buildRegisterText(state, Dispatch dispatch, ViewService viewService) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '还没有账号?',
          style: TextStyle(
              color: ColorUtil.auxiliaryTextColor,
              fontSize: Constants.mainTextSize),
        ),
        Gap.makeGap(width: 5),
        Text('点击注册',
                style: TextStyle(
                    color: ColorUtil.mainColor,
                    fontSize: Constants.mainTextSize,
                    fontWeight: FontWeight.bold))
            .onTap(() {
          NavigatorUtil.push(viewService.context, RegisterPage());
        }),
      ],
    ),
  );
}

Widget _buildFindText(state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () {
      NavigatorUtil.push(
        viewService.context,
        FindPasswordPage(),
      );
    },
    child: Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Text(
        '找回密码',
        style: TextStyle(
            color: ColorUtil.mainTextColor,
            fontSize: Constants.mainTextSize,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget _buildLoginButton(
    LoginState state, Dispatch dispatch, ViewService viewService) {
  return LoginButton(
    onTap: state.canClickButton
        ? () async {
            FocusScope.of(viewService.context).unfocus();
            dispatch(LoginActionCreator.requestLogin());
          }
        : null,
  );
}

Widget _buildVerificationCodeLoginText(
    state, Dispatch dispatch, ViewService viewService) {
  return Padding(
    padding: const EdgeInsets.only(left: 0),
    child: GestureDetector(
        onTap: () {
          NavigatorUtil.push(
            viewService.context,
            VerifyCodeLoginPage(),
          );
        },
        child: Text('短信登陆',
            style: TextStyle(
                color: ColorUtil.mainTextColor,
                fontSize: Constants.mainTextSize,
                fontWeight: FontWeight.bold))),
  );
}

///账号输入
Widget _accountTextField(
    LoginState state, Dispatch dispatch, ViewService viewService) {
  return CustomTextField(
    headerText: "请输入手机号",
    controller: state.accountController,
    focusNode: state.accountFocusNode,
    keyboardType: TextInputType.phone,
    inputFormatters: [
      WhitelistingTextInputFormatter(RegExp("[0-9]")),
      LengthLimitingTextInputFormatter(11),
    ],
  );
}

///密码输入框
Widget _passwordTextField(
    LoginState state, Dispatch dispatch, ViewService viewService) {
  return CustomTextField(
      controller: state.passwordController,
      focusNode: state.passwordFocusNode,
      keyboardType: TextInputType.text,
      inputFormatters: [
        BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]"))
      ],
      obscureText: true,
      headerText: "请输入密码");
}

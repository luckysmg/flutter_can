import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neng/redux/base_state.dart';
import 'package:neng/store/global_store.dart';

class LoginState with BaseState implements Cloneable<LoginState> {
  TextEditingController accountController;
  TextEditingController passwordController;
  bool canClickButton;
  FocusNode accountFocusNode;
  FocusNode passwordFocusNode;

  ///是否能清除密码
  bool showClearIcon;

  @override
  LoginState clone() {
    return LoginState()
      ..accountController = accountController
      ..passwordController = passwordController
      ..canClickButton = canClickButton
      ..showClearIcon = showClearIcon
      ..accountFocusNode = accountFocusNode
      ..passwordFocusNode = passwordFocusNode;
  }
}

LoginState initState(Map<String, dynamic> args) {
  GlobalStore.isShowingLoginPage = true;
  return LoginState()
    ..accountController = TextEditingController()
    ..passwordController = TextEditingController()
    ..passwordFocusNode = FocusNode()
    ..accountFocusNode = FocusNode()
    ..canClickButton = false
    ..showClearIcon = false;
}

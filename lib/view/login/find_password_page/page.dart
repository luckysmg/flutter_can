import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/entity/login_entity.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/RxgUtil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/dialog_util.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/input_formatter_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/view/login/widgets/login_button.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/custuom_text_field.dart';

///
/// @created by 文景睿
/// description:找回密码重置密码的页面
///
class FindPasswordPage extends StatefulWidget {
  @override
  _FindPasswordPageState createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  TextEditingController phoneNumController;
  TextEditingController codeController;
  TextEditingController passwordController;
  FocusNode phoneNode;
  FocusNode codeNode;
  FocusNode passwordNode;
  int countDownTime;
  Timer timer;
  bool hasSendCode = false;
  bool canClick;

  void startCountdown() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countDownTime == 0) {
        hasSendCode = false;
        countDownTime = 60;
        setState(() {});
        timer.cancel();
      } else {
        countDownTime--;
        setState(() {});
      }
    });
  }

  ///获取验证码
  void getCode() {
    if (!RxgUtil.isChinaPhoneNum(phoneNumController.text)) {
      TipUtil.showWaring(context: context, message: '请填写正确号码');
      return;
    }
    hasSendCode = true;
    setState(() {});
    startCountdown();
    DioUtil.getInstance().doPost<SimpleEntity>(
        url: API.reset_password_code,
        context: context,
        param: {'mobile': phoneNumController.text},
        onSuccess: (data) {
          TipUtil.show(context: context, message: '验证码已发送');
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }

  ///请求注册
  void resetPassword() async {
    phoneNode.unfocus();
    codeNode.unfocus();
    passwordNode.unfocus();
    if (phoneNumController.text.isEmpty ||
        !RxgUtil.isChinaPhoneNum(phoneNumController.text)) {
      TipUtil.showWaring(context: context, message: '请填写正确号码');
      return;
    }
    if (codeController.text.length != 6) {
      TipUtil.showWaring(context: context, message: '请输入正确验证码');
      return;
    }
    if (passwordController.text.length < 6 ||
        passwordController.text.length > 20) {
      TipUtil.showWaring(context: context, message: '密码位数6-20');
      return;
    }

    DialogUtil.showLoadingDialog(context: context);
    DioUtil.getInstance().doPost<LoginEntity>(
        url: API.reset_password,
        context: context,
        param: {
          'mobile': phoneNumController.text,
          'smsCode': codeController.text,
          'loginPass': passwordController.text,
        },
        onSuccess: (data) async {
          DialogUtil.closeLoadingDialog(context);
          Navigator.pop(context);
          TipUtil.show(context: context, message: "重置成功");
        },
        onFailure: (e) {
          DialogUtil.closeLoadingDialog(context);
          TipUtil.showWaring(context: context, message: e.msg);
        });
  }

  @override
  void dispose() {
    codeController?.dispose();
    codeNode?.dispose();
    passwordNode?.dispose();
    passwordController?.dispose();
    phoneNode?.dispose();
    phoneNumController?.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    canClick = false;
    countDownTime = 60;
    passwordNode = FocusNode();
    phoneNode = FocusNode();
    codeNode = FocusNode();
    phoneNumController = TextEditingController();
    codeController = TextEditingController();
    passwordController = TextEditingController();
    passwordController.addListener(check);
    codeController.addListener(check);
    phoneNumController.addListener(check);
  }

  void check() {
    bool enabled = false;
    String code = codeController.text;
    String phoneNum = phoneNumController.text;
    String password = passwordController.text;
    if (code.length == 6 &&
        RxgUtil.isChinaPhoneNum(phoneNum) &&
        password.length >= 6 &&
        password.length <= 20) {
      enabled = true;
    }

    if (enabled != canClick) {
      canClick = enabled;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        passwordNode.unfocus();
        phoneNode.unfocus();
        codeNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorUtil.scaffoldColor,
        resizeToAvoidBottomPadding: false,
        appBar: CustomNavigationBar(
          noBorder: true,
          backgroundColor: ColorUtil.scaffoldColor,
          fullScreenDialog: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('重置登录密码',
                    style: TextStyle(
                        fontSize: Constants.titleTextSize,
                        fontWeight: FontWeight.bold))
                .center(),

            Gap.makeGap(height: 40),

            ///电话
            _buildNumTextField(),

            Gap.makeGap(height: 20),

            ///验证码输入
            Row(
              children: <Widget>[
                _buildCodeTextField(),
                _buildGetCodeButton(),
              ],
            ).paddingRight(15),

            Gap.makeGap(height: 20),

            ///密码
            _buildPasswordTextField(),
            Gap.makeGap(height: 20),

            ///按钮
            _buildButton(),
          ],
        ).paddingSymmetric(horizontal: 8).withHeight(ScreenUtil.screenHeightDp),
      ),
    );
  }

  Widget _buildNumTextField() {
    return CustomTextField(
      controller: phoneNumController,
      focusNode: phoneNode,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(11),
      ],
      keyboardType: TextInputType.number,
      headerText: "请输入注册手机号",
    );
  }

  Widget _buildCodeTextField() {
    return CustomTextField(
      focusNode: codeNode,
      controller: codeController,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(11),
      ],
      headerText: "请输入验证码",
    ).expand();
  }

  Widget _buildPasswordTextField() {
    return CustomTextField(
      controller: passwordController,
      focusNode: passwordNode,
      obscureText: true,
      headerText: "请输入登录密码",
    );
  }

  Widget _buildButton() {
    return LoginButton(
      onTap: canClick
          ? () {
              resetPassword();
            }
          : null,
      feedBack: false,
    );
  }

  Widget _buildGetCodeButton() {
    return GestureDetector(
      onTap: () {
        if (!hasSendCode) {
          getCode();
        }
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ColorUtil.auxiliaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Text(
            hasSendCode ? '重新获取($countDownTime)' : '获取验证码',
            style: TextStyle(
                fontSize: Constants.auxiliaryTextSize,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ).paddingTop(27);
  }
}

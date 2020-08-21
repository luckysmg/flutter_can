import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/entity/login_entity.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/entity/user_profile_entity.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/RxgUtil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/dialog_util.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/input_formatter_util.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/view/login/widgets/login_button.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/custuom_text_field.dart';

///
/// @created by 文景睿
/// description:注册页面
///
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
        url: API.register_code,
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
  void register() async {
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
        url: API.register,
        context: context,
        param: {
          'mobile': phoneNumController.text,
          'smsCode': codeController.text,
          'loginPass': passwordController.text,
        },
        onSuccess: (data) async {
          await UserProfileUtil.setUserHasLogin(
              accessToken: data.accessToken,
              refreshToken: data.refreshToken,
              validTime: data.refreshTime);
          requestUserDetailInfo();
        },
        onFailure: (e) {
          DialogUtil.closeLoadingDialog(context);
          ToastUtil.show(e.msg);
        });
  }

  ///注册成功后自动登陆，并且发送更新界面的事件
  void requestUserDetailInfo() {
    DioUtil.getInstance().doPost<UserProfileEntity>(
        url: API.user_profile,
        context: context,
        onSuccess: (data) async {
          await UserProfileUtil.setUserDetailInfo(data);
          GlobalStore.getEventBus().fire(UserInfoChangeEvent());
          DialogUtil.closeLoadingDialog(context);
          TipUtil.show(context: context, message: '注册成功');
          NavigatorUtil.popToHome(context);
        },
        onFailure: (e) {
          DialogUtil.closeLoadingDialog(context);
          ToastUtil.show(e.msg);
        });
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
    phoneNumController.addListener(check);
    codeController.addListener(check);
    passwordController.addListener(check);
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
            Text(
              '注册',
            )
                .withStyle(
                    fontSize: Constants.titleTextSize,
                    fontWeight: FontWeight.bold)
                .center(),
            Gap.makeGap(height: 40),

            ///电话
            _buildNumTextField(),
            Gap.makeGap(height: 20),

            ///验证码
            Row(
              children: <Widget>[
                _buildCodeTextField(),
                _buildGetCodeButton(),
              ],
            ).paddingRight(15),
            Gap.makeGap(height: 20),

            ///密码
            _buildPasswordTextField(),
            Gap.makeGap(height: 30),

            ///按钮
            _buildRegisterButton(),
            const Spacer(),
            _buildTip(),
            Gap.makeGap(height: 40),
          ],
        ).paddingSymmetric(horizontal: 8).withHeight(ScreenUtil.screenHeightDp),
      ),
    );
  }

  Widget _buildTip() {
    return Text(
      '注册成功后自动登陆',
      style: TextStyle(
          color: ColorUtil.auxiliaryTextColor,
          fontSize: Constants.mainTextSize),
    ).center();
  }

  Widget _buildNumTextField() {
    return CustomTextField(
      controller: phoneNumController,
      focusNode: phoneNode,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(11),
      ],
      keyboardType: TextInputType.phone,
      headerText: "请输入手机号",
    );
  }

  Widget _buildCodeTextField() {
    return CustomTextField(
      focusNode: codeNode,
      inputFormatters: InputFormatterUtil.onlyNum,
      controller: codeController,
      keyboardType: TextInputType.phone,
      headerText: "请输入验证码",
    ).expand();
  }

  Widget _buildPasswordTextField() {
    return CustomTextField(
      controller: passwordController,
      focusNode: passwordNode,
      obscureText: true,
      headerText: "请设置密码",
    );
  }

  Widget _buildRegisterButton() {
    return LoginButton(
      onTap: canClick
          ? () {
              register();
            }
          : null,
    );
//    return Padding(
//      padding: const EdgeInsets.all(8.0),
//      child: CupertinoButton(
//        pressedOpacity: 0.7,
//        borderRadius: BorderRadius.circular(4),
//        color: Constants.mainColor,
//        disabledColor: Constants.dark_button_disabled,
//        child: Container(
//          alignment: Alignment.center,
//          child: Text(
//            '注册',
//            style: TextStyle(
//              color: Colors.white,
//              fontSize: ScreenUtil().setSp(32),
//            ),
//          ),
//        ),
//        onPressed: canClick
//            ? () {
//                register();
//              }
//            : null,
//      ),
//    );
  }

  Widget _buildGetCodeButton() {
    return GestureDetector(
      onTap: () {
        if (!hasSendCode) {
          getCode();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorUtil.auxiliaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Text(hasSendCode ? '重新获取($countDownTime)' : '获取验证码',
              style: TextStyle(
                  fontSize: Constants.auxiliaryTextSize,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    ).paddingTop(27);
  }
}

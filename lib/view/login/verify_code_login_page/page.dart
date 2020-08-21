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
import 'package:neng/view/login/register_page/register_page.dart';
import 'package:neng/view/login/widgets/login_button.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/custuom_text_field.dart';

///
/// @created by 文景睿
/// description:验证码登陆
///
class VerifyCodeLoginPage extends StatefulWidget {
  @override
  _VerifyCodeLoginPageState createState() => _VerifyCodeLoginPageState();
}

class _VerifyCodeLoginPageState extends State<VerifyCodeLoginPage> {
  TextEditingController phoneController;
  TextEditingController codeController;
  FocusNode phoneNode;
  FocusNode codeNode;
  Timer timer;
  bool hasSendCode = false;
  int countDownTime;
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
    if (!RxgUtil.isChinaPhoneNum(phoneController.text)) {
      TipUtil.showWaring(context: context, message: '请填写正确号码');
      return;
    }
    hasSendCode = true;
    setState(() {});
    startCountdown();
    DioUtil.getInstance().doPost<SimpleEntity>(
        url: API.sms_login_code,
        context: context,
        param: {'mobile': phoneController.text},
        onSuccess: (data) {
          TipUtil.show(context: context, message: '验证码已发送');
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }

  ///请求登录
  void login() async {
    phoneNode.unfocus();
    codeNode.unfocus();
    if (phoneController.text.isEmpty ||
        !RxgUtil.isChinaPhoneNum(phoneController.text)) {
      TipUtil.showWaring(context: context, message: '请填写正确号码');
      return;
    }
    if (codeController.text.length != 6) {
      TipUtil.showWaring(context: context, message: '请输入正确验证码');
      return;
    }

    DialogUtil.showLoadingDialog(context: context);
    DioUtil.getInstance().doPost<LoginEntity>(
        url: API.sms_login,
        context: context,
        param: {
          'mobile': phoneController.text,
          'smsCode': codeController.text,
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
    phoneController = TextEditingController();
    codeController = TextEditingController();
    phoneNode = FocusNode();
    codeNode = FocusNode();
    phoneController.addListener(check);
    codeController.addListener(check);
  }

  void check() {
    bool enabled = false;
    String phone = phoneController.text;
    String code = codeController.text;
    if (RxgUtil.isChinaPhoneNum(phone) && code.length == 6) {
      enabled = true;
    }
    if (enabled != canClick) {
      canClick = enabled;
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    phoneController.dispose();
    codeController.dispose();
    phoneNode.dispose();
    codeNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
          children: <Widget>[
            Text('短信登录',
                    style: TextStyle(
                        fontSize: Constants.titleTextSize,
                        fontWeight: FontWeight.bold))
                .center(),

            Gap.makeGap(height: 40),

            ///手机输入
            _buildPhoneTextField(),
            Gap.makeGap(height: 20),

            ///验证码输入
            Row(
              children: <Widget>[
                _buildCodeTextField(),
                _buildGetCodeButton(),
              ],
            ).paddingRight(15),
            Gap.makeGap(height: 60),
            _buildLoginButton(),
            const Spacer(),
            _buildRegisterText(),
            Gap.makeGap(height: 40),
          ],
        ).paddingSymmetric(horizontal: 8).withHeight(ScreenUtil.screenHeightDp),
      ),
    );
  }

  Widget _buildPhoneTextField() {
    return CustomTextField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(11),
      ],
      headerText: "请输入手机号",
      focusNode: phoneNode,
    );
  }

  Widget _buildCodeTextField() {
    return CustomTextField(
      controller: codeController,
      keyboardType: TextInputType.number,
      inputFormatters: InputFormatterUtil.onlyNum,
      headerText: "请输入验证码",
      focusNode: codeNode,
    ).expand();
  }

  Widget _buildRegisterText() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '还没有账号?',
            style: TextStyle(color: ColorUtil.auxiliaryTextColor),
          ),
          Gap.makeGap(width: 5),
          Text('点击注册',
                  style: TextStyle(
                      color: ColorUtil.mainColor, fontWeight: FontWeight.w500))
              .onTap(() {
            NavigatorUtil.push(context, RegisterPage());
          }),
        ],
      ),
    );
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

  ///登录按钮
  Widget _buildLoginButton() {
    return LoginButton(
      onTap: canClick
          ? () {
              login();
            }
          : null,
    );
  }
}

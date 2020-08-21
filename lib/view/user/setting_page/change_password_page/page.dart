import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/staus_bar_wrapper.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldPasswordController,
      newPasswordController,
      newRePasswordController;
  FocusNode oldPasswordFocusNode, newPasswordFocusNode, newRePasswordFocusNode;

  @override
  void initState() {
    super.initState();
    oldPasswordFocusNode = FocusNode();
    newPasswordFocusNode = FocusNode();
    newRePasswordFocusNode = FocusNode();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    newRePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    newRePasswordFocusNode.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    newRePasswordController.dispose();
  }

  void _submit() {
    String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;
    String newRePassword = newRePasswordController.text;
    if (oldPassword.isEmpty || newPassword.isEmpty) {
      return;
    } else if (newPassword != newRePassword) {
      TipUtil.show(
          context: context,
          message: '两次密码输入不一致',
          imgPath: Constants.TIP_WARNING);
    } else if (newPassword.length < 6) {
      TipUtil.show(
          context: context, message: '密码太短了', imgPath: Constants.TIP_WARNING);
    } else {
      DioUtil.getInstance().doPost<SimpleEntity>(
          url: API.password_modify,
          param: {'loginPass': oldPassword, 'newLoginPass': newPassword},
          context: context,
          onSuccess: (data) async {
            oldPasswordFocusNode.unfocus();
            newPasswordFocusNode.unfocus();
            newRePasswordFocusNode.unfocus();
            TipUtil.show(context: context, message: '保存成功');
            Navigator.pop(context);
          },
          onFailure: (e) {
            ToastUtil.show(e.msg);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarWrapper(
      child: GestureDetector(
        onTap: () {
          oldPasswordFocusNode.unfocus();
          newPasswordFocusNode.unfocus();
          newRePasswordFocusNode.unfocus();
        },
        child: Scaffold(
          appBar: CustomNavigationBar(
            title: '修改密码',
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: <Widget>[
                Gap.makeGap(height: 15),
                _buildOldPasswordTextField(),
                Gap.makeGap(height: 15),
                _buildNewPasswordTextField(),
                Gap.makeGap(height: 15),
                _buildNewRePasswordTextField(),
                _buildTip(),
                Gap.makeGap(height: 50),

                ///按钮
                _buildButton(),

                ///end
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Center(
      child: CupertinoButton(
          padding:
              EdgeInsets.symmetric(horizontal: ScreenUtil.screenWidthDp * 0.4),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          color: ColorUtil.mainColor,
          pressedOpacity: 0.7,
          child: Text('确认'),
          onPressed: () => _submit()),
    );
  }

  Widget _buildTip() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 10),
      child: Text('密码不少于6个字符，支持英文，数字，不支持特殊字符',
          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black45)),
    );
  }

  Widget _buildOldPasswordTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        focusNode: oldPasswordFocusNode,
        controller: oldPasswordController,
        inputFormatters: [
          BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]"))
        ],
        decoration: InputDecoration(
            hintText: '请输入原密码',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
      ),
    );
  }

  Widget _buildNewPasswordTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        focusNode: newPasswordFocusNode,
        controller: newPasswordController,
        inputFormatters: [
          BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]"))
        ],
        decoration: InputDecoration(
            hintText: '请输入新密码',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
      ),
    );
  }

  Widget _buildNewRePasswordTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        focusNode: newRePasswordFocusNode,
        controller: newRePasswordController,
        inputFormatters: [
          BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]"))
        ],
        decoration: InputDecoration(
            hintText: '请再次输入新密码',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
      ),
    );
  }

  Widget _buildLeading() {
    return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_ios,
          size: 24,
        ));
  }
}

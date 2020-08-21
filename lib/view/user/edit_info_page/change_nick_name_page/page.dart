import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/entity/user_profile_entity.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';

import '../../../../util/constants.dart';

///
/// @created by 文景睿
/// description:修改昵称页面
///
class ChangeNickNamePage extends StatefulWidget {
  @override
  _ChangeNickNamePageState createState() => _ChangeNickNamePageState();
}

class _ChangeNickNamePageState extends State<ChangeNickNamePage> {
  TextEditingController controller;
  FocusNode focusNode;
  bool canClick;

  @override
  void initState() {
    super.initState();
    canClick = false;
    focusNode = FocusNode();
    controller = TextEditingController(
        text: UserProfileUtil.getUserDetailInfo().nickName ?? '');
    controller.addListener(check);
  }

  void check() {
    bool enabled = false;
    String newNickName = controller.text;
    if (newNickName != UserProfileUtil.getUserDetailInfo().nickName &&
        newNickName.isNotEmpty &&
        newNickName.length >= 2) {
      enabled = true;
    }
    if (enabled != canClick) {
      canClick = enabled;
      setState(() {});
    }
  }

  void _submit() {
    String newName = controller.text;
    focusNode.unfocus();

    ///如果一样，那就不提交修改，直接pop
    if (newName == UserProfileUtil.getUserDetailInfo().nickName) {
      focusNode.unfocus();
      Navigator.pop(context);
      return;
    }
    if (newName.isEmpty) {
      return;
    } else if (newName.length < 2) {
      ToastUtil.show('名字长度过短');
    } else {
      DioUtil.getInstance().doPost<SimpleEntity>(
          url: API.save_nickname,
          param: {'nickName': newName},
          context: context,
          onSuccess: (data) async {
            focusNode.unfocus();
            UserProfileEntity entity = UserProfileUtil.getUserDetailInfo();
            entity.nickName = newName;
            await UserProfileUtil.setUserDetailInfo(entity);
            GlobalStore.getEventBus().fire(UserInfoChangeEvent());
            Navigator.pop(context);
          },
          onFailure: (e) {
            ToastUtil.show(e.msg);
          });
    }
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        appBar: CustomNavigationBar(
          darkIcon: true,
          title: '昵称修改',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ///start
                Gap.makeGap(height: 15),

                ///输入框
                _buildTextField(),

                Gap.makeGap(height: 10),

                _buildTip(),

                Gap.makeGap(height: 30),

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
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: CupertinoButton(
        pressedOpacity: 0.7,
        borderRadius: BorderRadius.circular(4),
        color: ColorUtil.mainColor,
        disabledColor: ColorUtil.disabledButtonColor,
        child: Container(
            alignment: Alignment.center,
            child: Text('完成', style: TextStyle(color: Colors.white))),
        onPressed: canClick
            ? () {
                _submit();
              }
            : null,
      ),
    );
  }

  Widget _buildTip() {
    return Container(
      child: Text('长度为2 - 12，支持中文/英文/数字，不支持特殊字符',
          style: TextStyle(
              color: ColorUtil.auxiliaryTextColor,
              fontSize: Constants.secondTextSize)),
    );
  }

  Widget _buildTextField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: ColorUtil.auxiliaryColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        focusNode: focusNode,
        controller: controller,
        maxLength: 12,
        inputFormatters: [
          BlacklistingTextInputFormatter(RegExp("[' ']")),
          WhitelistingTextInputFormatter(
              RegExp("[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]")),
          LengthLimitingTextInputFormatter(12),
        ],
        decoration: InputDecoration(
            hintText: '请输入你的昵称',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
      ),
    );
  }
}

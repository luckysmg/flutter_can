import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/entity/user_profile_entity.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';

///
/// @created by 文景睿
/// description:编辑性别页面
///
class EditGenderPage extends StatefulWidget {
  @override
  _EditGenderPageState createState() => _EditGenderPageState();
}

class _EditGenderPageState extends State<EditGenderPage> {
  bool canClick;
  TextEditingController controller;

  /// 0 男，1女 2保密
  var flag;
  var currentFlag;
  var gender;

  void requestChangeGender() {
    DioUtil.getInstance().doPost<SimpleEntity>(
        url: API.change_gender,
        context: context,
        param: {'gender': gender},
        onSuccess: (data) async {
          UserProfileEntity userDetailInfo =
              UserProfileUtil.getUserDetailInfo();
          userDetailInfo.gender = gender;
          await UserProfileUtil.setUserDetailInfo(userDetailInfo);
          GlobalStore.getEventBus().fire(UserInfoChangeEvent());
          //await TipUtil.show(context: context, message: '保存成功', timeInMs: 1000);
          Navigator.pop(context);
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }

  @override
  void initState() {
    super.initState();
    canClick = false;
    controller = TextEditingController(
        text: UserProfileUtil.getUserDetailInfo().gender ?? '-1');
    //controller.addListener(check);
    gender = UserProfileUtil.getUserDetailInfo().gender;
    if (gender != null) {
      if (gender == "MALE") {
        flag = 0;
      } else if (gender == 'FEMALE') {
        flag = 1;
      } else {
        flag = 2;
      }
    } else {
      flag = -1;
    }
    currentFlag = flag;
  }

  void check() {
    String gender = controller.text;

    if (gender == '0') {
      gender = 'MALE';
    } else if (gender == '1') {
      gender = 'FEMALE';
    } else if (gender == '2') {
      gender = 'SECRECY';
    }
    bool enabled = false;
    if (gender != UserProfileUtil.getUserDetailInfo().gender) {
      enabled = true;
    } else {
      enabled = false;
    }
    if (enabled != canClick) {
      canClick = enabled;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentFlag == 0) {
      gender = 'MALE';
    } else if (currentFlag == 1) {
      gender = 'FEMALE';
    } else if (currentFlag == 2) {
      gender = 'SECRECY';
    }

    return Scaffold(
      appBar: CustomNavigationBar(
        darkIcon: true,
        title: "设置性别",
      ),
      body: Container(
        //padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            Gap.makeGap(height: 5),
            Column(
              children: _buildWidgets(),
            ),
            Gap.makeGap(height: 20),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                requestChangeGender();
              }
            : null,
      ),
    );
  }

  List<Widget> _buildWidgets() {
    return List.generate(3, (i) {
      var text;
      if (i == 0) {
        text = '男';
      } else if (i == 1) {
        text = '女';
      } else {
        text = '保密';
      }
      return Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              currentFlag = i;
              setState(() {
                controller =
                    TextEditingController(text: currentFlag.toString());
                check();
              });
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 10, bottom: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: Constants.mainTextSize,
                      ),
                    ),
                    Icon(
                        i == currentFlag
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        size: 26,
                        color: i == currentFlag
                            ? ColorUtil.mainColor
                            : ColorUtil.auxiliaryTextColor),
//                    LoadAssetImage(
//                      i == currentFlag ? 'ico_circle_selected' : 'ico_circle',
//                      width: 30,
//                    ),
                  ],
                ),
              ),
            ),
          ),
          Gap.line(),
        ],
      );
    });
  }
}

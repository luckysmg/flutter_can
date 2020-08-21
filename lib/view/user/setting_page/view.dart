import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/view/user/about_us_page/page.dart';
import 'package:neng/view/user/setting_page/change_password_page/page.dart';
import 'package:neng/widgets/click_image_item.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/need_login_click_image_item.dart';
import 'package:neng/widgets/staus_bar_wrapper.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SettingState state, Dispatch dispatch, ViewService viewService) {
  return StatusBarWrapper(
    child: Scaffold(
      appBar: CustomNavigationBar(
        title: '设置',
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            NeedLoginClickImageItem(
              title: "修改密码",
              imageLocal: "setting/ico_me_list_feedback",
              onTap: () {
                NavigatorUtil.push(viewService.context, ChangePasswordPage());
              },
            ),
            Gap.line(),
            NeedLoginClickImageItem(
              title: "反馈建议",
              imageLocal: "setting/ico_me_list_feedback",
              onTap: () {},
            ),
            Gap.line(),
            ClickImageItem(
              title: "关于我们",
              imageLocal: "setting/ico_me_list_about",
              onTap: () => NavigatorUtil.push(
                  viewService.context, AboutUsPage(),
                  rootNavigator: true),
            ),
            Gap.line(),
            Gap.makeGap(height: 60),
            _buildLogOutButton(state, dispatch, viewService),
          ],
        ),
      ),
    ),
  );
}

Widget _buildArrow() {
  return Icon(
    Icons.keyboard_arrow_right,
    size: 20,
    color: ColorUtil.mainTextColor,
  );
}

Widget _buildItem(SettingState state, ViewService viewService, String text,
    VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Container(
      padding: const EdgeInsets.fromLTRB(16, 0.0, 16.0, 0.0),
      constraints: BoxConstraints(maxHeight: double.infinity, minHeight: 50.0),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: ScreenUtil().setSp(30),
              ),
            ),
          ),
          _buildArrow(),
        ],
      ),
    ),
  );
}

Widget _buildLogOutButton(
    SettingState state, Dispatch dispatch, ViewService viewService) {
  return UserProfileUtil.isUserLogin()
      ? GestureDetector(
          onTap: () {
            dispatch(SettingActionCreator.userLogout());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.redAccent),
              ),
              child: Text(
                '退出登录',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    fontWeight: FontWeight.w600,
                    color: Colors.redAccent),
              ),
            ),
          ),
        )
      : Gap.empty;
}

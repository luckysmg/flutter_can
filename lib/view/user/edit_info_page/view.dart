import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/view/select_profession_page/page.dart';
import 'package:neng/view/user/edit_info_page/action.dart';
import 'package:neng/view/user/edit_info_page/edit_gender_page/page.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/load_asset_image.dart';

import 'change_nick_name_page/page.dart';
import 'state.dart';

Widget buildView(
    EditInfoState state, Dispatch dispatch, ViewService viewService) {
  var gender;
  if (UserProfileUtil.getUserDetailInfo().gender == null) {
    gender = '未设置';
  } else {
    if (UserProfileUtil.getUserDetailInfo().gender == 'MALE') {
      gender = "男";
    } else if (UserProfileUtil.getUserDetailInfo().gender == 'FEMALE') {
      gender = '女';
    } else {
      gender = '保密';
    }
  }
  final nickName = UserProfileUtil.getUserDetailInfo().nickName ?? '未设置';
  final professionName =
      UserProfileUtil.getUserDetailInfo().professionName ?? '未设置';

  return Scaffold(
    appBar: CustomNavigationBar(
      darkIcon: true,
      title: '编辑资料',
    ),
    body: Container(
      child: ListView(
        children: <Widget>[
          ///头像
          _buildHeadItem(state, dispatch, viewService),
          Gap.line(),
          _buildItem(state, viewService, '性别', gender, () {
            NavigatorUtil.push(viewService.context, EditGenderPage());
          }),
          Gap.line(),
          _buildItem(state, viewService, '昵称', nickName, () {
            NavigatorUtil.push(viewService.context, ChangeNickNamePage());
          }),
          Gap.line(),
          _buildItem(state, viewService, '我的理想职业', professionName, () {
            NavigatorUtil.push(
                viewService.context, SelectProfessionPage().buildPage({}));
          }),
          Gap.line(),
        ],
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

void _showSheet(BuildContext context, Dispatch dispatch) async {
  var useCamera;
  useCamera = await showModalBottomSheet<bool>(
      context: context,
      builder: (ctx) {
        var cameraItemView = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context, true);
          },
          child: Container(
            color: ColorUtil.whiteColor,
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                '拍照',
                style: TextStyle(
                  fontSize: Constants.mainTextSize,
                  color: ColorUtil.mainTextColor,
                ),
              ),
            ),
          ),
        );

        var imgItemView = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context, false);
          },
          child: Container(
            color: ColorUtil.whiteColor,
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                '相册',
                style: TextStyle(
                  fontSize: Constants.mainTextSize,
                  color: ColorUtil.mainTextColor,
                ),
              ),
            ),
          ),
        );

        return Container(
          color: ColorUtil.auxiliaryColor,
          height: Platform.isAndroid ? 150 : 180,
          child: Column(
            children: <Widget>[
              cameraItemView,
              Gap.line(),
              imgItemView,
              Gap.line(),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: Platform.isAndroid ? 50 : 80,
                    alignment: Alignment.center,
                    margin:
                    EdgeInsets.only(bottom: Platform.isAndroid ? 0 : 30),
                    width: double.infinity,
                    child: Text('取消',
                        style: TextStyle(
                            color: ColorUtil.mainTextColor,
                            fontSize: Constants.mainTextSize)),
                  ),
                ),
              )
            ],
          ),
        );
      });

  if (useCamera == null) {
    return;
  }
  dispatch(EditInfoActionCreator.selectHeadImg(useCamera));
}

Widget _buildHeadItem(
    EditInfoState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () {
      _showSheet(viewService.context, dispatch);
    },
    behavior: HitTestBehavior.opaque,
    child: Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10, right: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '头像',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: ScreenUtil().setSp(30),
              ),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.only(right: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: UserProfileUtil.getUserDetailInfo().headImageUrl == null
                  ? LoadAssetImage(
                      'default/default_head',
                      height: 50,
                    )
                  : CachedNetworkImage(
                      imageUrl:
                          UserProfileUtil.getUserDetailInfo().headImageUrl,
                      placeholder: (_, __) => LoadAssetImage(
                        'default/default_head',
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (_, __, ___) => LoadAssetImage(
                        'default/default_head',
                        height: 50,
                      ),
                    ),
            ),
          ),
          _buildArrow(),
        ],
      ),
    ),
  );
}

Widget _buildItem(EditInfoState state, ViewService viewService, String text,
    String content, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Container(
      height: 50,
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 10),
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
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(content,
                style: TextStyle(fontSize: ScreenUtil().setSp(28))),
          ),
          _buildArrow(),
        ],
      ),
    ),
  );
}

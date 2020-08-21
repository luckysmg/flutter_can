import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/collection_page/page.dart';
import 'package:neng/view/comment_page/page.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/view/user/setting_page/page.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/need_login_click_wrapper.dart';
import 'package:neng/widgets/staus_bar_wrapper.dart';

import 'state.dart';

Widget buildView(MyState state, Dispatch dispatch, ViewService viewService) {
  ScreenUtil(width: 750, height: 1334, allowFontScaling: false)
    ..init(viewService.context);

  return StatusBarWrapper(
    statusBarTextIsBlack: true,
    child: Scaffold(
      appBar: _buildTopBar(state, dispatch, viewService),
      body: EasyRefresh(
        child: ListView(
          children: <Widget>[
            viewService.buildComponent('header'),
            Gap.makeGap(height: 10),
            Gap.line(),
            Gap.makeGap(height: 10),
            _fourItem(viewService),
            Gap.makeGap(height: 10),
            Gap.makeLineWithThickness(thicknessHeight: 4),
          ],
        ),
      ),
    ),
  );
}

PreferredSizeWidget _buildTopBar(
    state, Dispatch dispatch, ViewService viewService) {
  return CupertinoNavigationBar(
    border: null,
    trailing: LoadAssetImage(
      "setting/ico_me_list_setting",
      height: 30,
      fit: BoxFit.cover,
    ).onTap(() {
      NavigatorUtil.push(viewService.context, SettingPage().buildPage(null),
          rootNavigator: true);
    }),
  );
}

Widget _fourItem(ViewService viewService) {
  return Row(
    children: <Widget>[
      _item(text: '我的课程', imgPath: 'function/ico_me_class', onTap: () {}),
      _item(
          text: '收藏',
          imgPath: 'function/ico_me_collect',
          onTap: () => NavigatorUtil.push(
              viewService.context, CollectionPage().buildPage(null),
              rootNavigator: true)),
      _item(
          text: '评论',
          imgPath: 'function/ico_me_comment',
          onTap: () => NavigatorUtil.push(
              viewService.context, CommentPage().buildPage(null),
              rootNavigator: true)),
    ],
  );
}

Widget _item({String text, String imgPath, VoidCallback onTap}) {
  return Expanded(
    child: NeedLoginClickWrapper(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        child: Column(
          children: <Widget>[
            LoadAssetImage(
              imgPath,
              width: 40,
              height: 40,
            ),
            Gap.makeGap(height: 5),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Constants.auxiliaryTextSize,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

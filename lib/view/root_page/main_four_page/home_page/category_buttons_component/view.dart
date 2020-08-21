import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/certificate_page/page.dart';
import 'package:neng/view/class_page/page.dart';
import 'package:neng/view/knowledge_page/page.dart';
import 'package:neng/view/select_profession_page/page.dart';
import 'package:neng/widgets/load_asset_image.dart';

import '../state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: Container(
      child: Row(
        children: <Widget>[
          _item('function/home_ico_xingxing', '知识行星', () {
            NavigatorUtil.push(
                viewService.context, KnowledgePage().buildPage(null),
                rootNavigator: true);
          }),
          _item('function/home_ico_baike', '职业百科', () {
            NavigatorUtil.push(viewService.context,
                SelectProfessionPage().buildPage({'isFromSettingPage': false}),
                rootNavigator: true);
          }),
          _item('function/home_ico_kaozheng', '考证信息', () {
            NavigatorUtil.push(
                viewService.context, CertificatePage().buildPage(null),
                rootNavigator: true);
          }),
          _item('function/home_ico_fenlei', '课程分类', () {
            NavigatorUtil.push(viewService.context, ClassPage().buildPage(null),
                rootNavigator: true);
          }),
        ],
      ),
    ),
  );
}

Widget _item(String imgPath, String text, VoidCallback onTap) {
  return Expanded(
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          LoadAssetImage(
            imgPath,
            height: 50,
          ),
          Text(text,
              style: TextStyle(
                  fontSize: Constants.auxiliaryTextSize,
                  color: ColorUtil.mainTextColor)),
          Gap.makeGap(height: 10),
        ],
      ),
    ),
  );
}

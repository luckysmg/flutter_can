import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/select_profession_page/search_professtion_page/page.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SelectProfessionState state, Dispatch dispatch, ViewService viewService) {
  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else if (state.professionListData == null) {
    body = LoadingView();
  } else {
    body = Column(
      children: <Widget>[
        Gap.makeGap(height: 10),
        _searchBox(state, dispatch, viewService),
        Gap.makeGap(height: 10),
        Expanded(
          child: Row(
            children: <Widget>[
              viewService.buildComponent('leftList'),
              viewService.buildComponent('rightList'),
            ],
          ),
        )
      ],
    );
  }

  return Scaffold(
    appBar: CustomNavigationBar(
      title: '选择职业',
    ),
    body: body,
  );
}

Widget _searchBox(
    SelectProfessionState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () async {
      bool selectSuccess = await NavigatorUtil.push(
              viewService.context,
              SearchProfessionPage(
                isFromSettingPage: state.isFromSettingPage,
              )) ??
          false;

      if (selectSuccess) {
        Navigator.pop(viewService.context);
      }
    },
    child: Container(
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      height: 48,
      //width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: ColorUtil.auxiliaryColor,
      ),
      child: Text(
        '搜索你感兴趣的职业',
        style: TextStyle(
            color: ColorUtil.secondaryTextColor,
            fontSize: Constants.secondTextSize),
      ),
    ),
  );
}

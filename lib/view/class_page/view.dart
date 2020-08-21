import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';

import 'state.dart';

Widget buildView(ClassState state, Dispatch dispatch, ViewService viewService) {
  ScreenUtil(width: 750, height: 1334, allowFontScaling: false)
    ..init(viewService.context);

  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else if (state.curriculumCategoryData == null) {
    body = LoadingView();
  } else {
    body = Row(
      children: <Widget>[
        viewService.buildComponent('leftList'),
        viewService.buildComponent('rightList'),
      ],
    );
  }
  return Scaffold(
    appBar: CustomNavigationBar(title: '课程分类'),
    body: body,
  );
}

///搜索框
Widget _inputBox(state, Dispatch dispatch, ViewService viewService) {
  return Material(
    child: Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      height: 34,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color.fromARGB(10, 0, 0, 0),
          borderRadius: BorderRadius.circular(2)),
      child: Text('搜索你想要的课程',
          style: TextStyle(
              color: ColorUtil.auxiliaryTextColor,
              fontSize: Constants.secondTextSize)),
    ),
  );
}

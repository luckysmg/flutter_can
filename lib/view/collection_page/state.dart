import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionState implements Cloneable<CollectionState> {
  PageController pageController;
  TabController tabController;
  List<Widget> tabs;
  @override
  CollectionState clone() {
    return CollectionState()
      ..tabs = tabs
      ..tabController = tabController
      ..pageController = pageController;
  }
}

CollectionState initState(Map<String, dynamic> args) {
  TextStyle style = TextStyle(fontSize: ScreenUtil().setSp(30));
  List<Widget> tabs = [
    Text(
      '课程',
      style: style,
    ),
    Text(
      '发现',
      style: style,
    ),
    Text(
      '考证',
      style: style,
    ),
    Text(
      '书籍',
      style: style,
    ),
  ];

  return CollectionState()
    ..tabs = tabs
    ..pageController = PageController();
}

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/constants.dart';

class RootState implements Cloneable<RootState> {
  ///bottomBar的集合
  List<BottomNavigationBarItem> barItems;

  DateTime lastPopTime;

  int currentIndex;

  @override
  RootState clone() {
    return RootState()
      ..barItems = barItems
      ..currentIndex = currentIndex;
  }
}

RootState initState(Map<String, dynamic> args) {
  var height = 26.0;
  final List<BottomNavigationBarItem> barItems = [
    BottomNavigationBarItem(
      title: Text('首页'),
      activeIcon: Image.asset(Constants.ASSETS_IMG + "ico_home_selected.png",
          height: height),
      icon: Image.asset(Constants.ASSETS_IMG + "ico_home.png", height: height),
    ),
    BottomNavigationBarItem(
      title: Text('职业'),
      activeIcon: Image.asset(
          Constants.ASSETS_IMG + "ico_profession_selected.png",
          height: height),
      icon: Image.asset(
        Constants.ASSETS_IMG + "ico_profession.png",
        height: height,
      ),
    ),
    BottomNavigationBarItem(
      title: Text('发现'),
      activeIcon: Image.asset(
          Constants.ASSETS_IMG + "ico_discover_selected.png",
          height: height),
      icon: Image.asset(Constants.ASSETS_IMG + "ico_discover.png",
          height: height),
    ),
    BottomNavigationBarItem(
      title: Text('我的'),
      activeIcon: Image.asset(Constants.ASSETS_IMG + "ico_me_selected.png",
          height: height),
      icon: Image.asset(Constants.ASSETS_IMG + "ico_me.png", height: height),
    ),
  ];

  return RootState()
    ..barItems = barItems
    ..currentIndex = 0;
}

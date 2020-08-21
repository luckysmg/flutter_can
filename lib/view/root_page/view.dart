import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/view/root_page/main_four_page/discover_page/page.dart';
import 'package:neng/view/root_page/main_four_page/home_page/action.dart';
import 'package:neng/view/root_page/main_four_page/home_page/page.dart';
import 'package:neng/view/root_page/main_four_page/my_page/page.dart';

import 'main_four_page/profession_page/page.dart';
import 'state.dart';

Widget buildView(RootState state, Dispatch dispatch, ViewService viewService) {
  ScreenUtil.instance =
      ScreenUtil(width: 750, height: 1334, allowFontScaling: false)
        ..init(viewService.context);
  var tabBar = CupertinoTabBar(
    activeColor: ColorUtil.mainColor,
    items: state.barItems,
    onTap: (index) {
      ///如果当前index为0且再次点击tab，那么把首页现在所在的滚动列表返回顶部
      if (index == 0 && state.currentIndex == 0) {
        viewService.broadcast(HomeActionCreator.scrollToTop());
      }
      state.currentIndex = index;
    },
  );
  return WillPopScope(
    onWillPop: () async {
      if (state.lastPopTime == null ||
          DateTime.now().difference(state.lastPopTime) > Duration(seconds: 2)) {
        state.lastPopTime = DateTime.now();
        ToastUtil.show('再按一次退出应用');
        return Future.value(false);
      } else {
        state.lastPopTime = DateTime.now();
        return Future.value(true);
      }
    },
    child: CupertinoTabScaffold(
        tabBar: tabBar,
        tabBuilder: (ctx, index) {
          return CupertinoTabView(
            builder: (ctx) {
              switch (index) {
                case 0:
                  return HomePage().buildPage(null);
                  break;
                case 1:
                  return ProfessionPage().buildPage(null);
                  break;
                case 2:
                  return DiscoverPage().buildPage(null);
                  break;
                case 3:
                  return MyPage().buildPage(null);
                  break;
                default:
                  return Container();
              }
            },
          );
        }),
  );
}

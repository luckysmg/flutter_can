import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/planet_detail_page/page.dart';
import 'package:neng/view/planet_info_page/planet_all_dynamic_info_page/page.dart';
import 'package:neng/view/publish_dynamic_info_page/page.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:neng/widgets/tab_page_view.dart';

import 'state.dart';

Widget buildView(
    PlanetInfoState state, Dispatch dispatch, ViewService viewService) {
  var body;

  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else if (state.planetDetailEntity == null) {
    body = LoadingView();
  } else {
    body = NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [viewService.buildComponent('header')];
        },
        body: TabPageView.builder(
            isScrollable: true,
            physics: const NeverScrollableScrollPhysics(),
            tabAlignment: Alignment.centerLeft,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: ColorUtil.mainColor,
            unselectedLabelColor: ColorUtil.mainTextColor,
            labelColor: ColorUtil.mainColor,
            indicatorWeight: 3,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
            labelStyle: TextStyle(
                color: ColorUtil.mainColor,
                fontSize: Constants.mainTextSize,
                fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(
                color: ColorUtil.mainTextColor,
                fontSize: Constants.mainTextSize),
            labelPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            tabs: [Text('全部'), Text('图片')],
            itemCount: 2,
            builder: (context, index) {
              return PlanetAllDynamicInfoPage().buildPage({
                'oid': state.oid,

                ///这里在内部是否能够上拉加载取决于是否加入了该星球
                'enableLoadMore':
                    state.planetDetailEntity.data.joinStatus == "YES",
              }).keepAlive();
            }));
  }

  var floatingActionButton = Container(
    margin: const EdgeInsets.only(bottom: 20, right: 20),
    child: FloatingActionButton(
      backgroundColor: ColorUtil.mainColor,
      child: Icon(Icons.add),
      onPressed: () {
        HapticFeedback.heavyImpact();
        NavigatorUtil.push(viewService.context,
            PublishDynamicInfoPage().buildPage({'oid': state.oid}),
            fullScreenDialog: true);
      },
    ),
  );
//  Container(
//    margin: const EdgeInsets.only(bottom: 30, right: 16),
//    height: 50,
//    width: 50,
//    child: Icon(
//      Icons.add,
//      color: Colors.white,
//    ),
//    decoration: BoxDecoration(
//        color: ColorUtil.mainColor, borderRadius: BorderRadius.circular(30)),
//  ).onTap(() {
//    HapticFeedback.heavyImpact();
//    NavigatorUtil.push(viewService.context,
//        PublishDynamicInfoPage().buildPage({'oid': state.oid}),
//        fullScreenDialog: true);
//  });

  var trailingView = Icon(
    Icons.menu,
    size: 26,
  ).onTap(() {
    NavigatorUtil.push(
        viewService.context, PlanetDetailPage().buildPage({'oid': state.oid}));
  });

  return Scaffold(
    floatingActionButton: state.planetDetailEntity == null ||
            state.planetDetailEntity.data.joinStatus != 'YES'
        ? Gap.empty
        : floatingActionButton,
    appBar: CustomNavigationBar(
      trailing: trailingView,
    ),
    body: body,
  );
}

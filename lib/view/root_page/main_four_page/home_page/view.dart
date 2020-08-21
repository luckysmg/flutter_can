import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/view/root_page/main_four_page/home_page/action.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:neng/widgets/staus_bar_wrapper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  ScreenUtil(width: 750, height: 1334, allowFontScaling: false)
    ..init(viewService.context);

  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () {
        dispatch(LifecycleCreator.initState());
      },
    );
  } else if (state.newClassData == null) {
    return LoadingView();
  } else {
    body = SmartRefresher(
      physics: const BouncingScrollPhysics(),
      onRefresh: () => dispatch(LifecycleCreator.initState()),
      onLoading: () => dispatch(HomeActionCreator.loadMore()),
      controller: state.refreshController,
      enablePullUp: true,
      child: CustomScrollView(
        controller: state.scrollController,
        slivers: <Widget>[
          viewService.buildComponent("banner"),

          ///四个按钮
          viewService.buildComponent('buttons'),

          ///免费课程列表
          viewService.buildComponent("freeClass"),

          ///精品课列表
          viewService.buildComponent("goodClass"),

          ///上新课程列表
          viewService.buildComponent("newClass"),
        ],
      ),
    ).paddingBottom(MediaQuery.of(viewService.context).padding.bottom);
  }
  return StatusBarWrapper(
    statusBarTextIsBlack: true,
    child: Scaffold(
      appBar: _buildTopBar(state, dispatch, viewService),
      body: body,
    ),
  );
}

PreferredSizeWidget _buildTopBar(
    state, Dispatch dispatch, ViewService viewService) {
  return CupertinoNavigationBar(
    middle: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Gap.makeGap(width: 10.0),
        Container(
          child: Text("首页").withStyle(
              fontSize: Constants.titleTextSize, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

//class _Dot extends StatelessWidget {
//  final Color color;
//  final double size;
//
//  const _Dot({Key key, this.color, this.size}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.circular(10),
//        color: color,
//      ),
//      height: size,
//      width: size,
//    );
//  }
//}

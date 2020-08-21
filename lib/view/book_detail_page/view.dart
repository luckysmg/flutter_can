import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    BookDetailState state, Dispatch dispatch, ViewService viewService) {
  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
        onTapButton: () => dispatch(LifecycleCreator.initState()));
  } else if (state.bookDetailData == null || state.commentsData == null) {
    body = LoadingView();
  } else {
    body = SmartRefresher(
      physics: const BouncingScrollPhysics(),
      enablePullDown: false,
      enablePullUp: state.commentsData.total > 0,
      controller: state.refreshController,
      onLoading: () => dispatch(BookDetailActionCreator.loadMore()),
      child: CustomScrollView(
        slivers: <Widget>[
          viewService.buildComponent('header'),
          SliverToBoxAdapter(
              child: Gap.makeLineWithThickness(thicknessHeight: 6)),

          ///简介
          viewService.buildComponent('introduction'),

          SliverToBoxAdapter(
              child: Gap.makeLineWithThickness(thicknessHeight: 6)),

          ///评论列表
          viewService.buildComponent('commentList'),
        ],
      ),
    );
  }
  return Scaffold(
    appBar: CustomNavigationBar(
      title: '详情',
    ),
    bottomNavigationBar: state.bookDetailData == null
        ? Gap.empty
        : viewService.buildComponent('bottom'),
    body: body,
  );
}

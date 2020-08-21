import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/view/essay_detail_page/action.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'state.dart';

Widget buildView(
    EssayDetailState state, Dispatch dispatch, ViewService viewService) {
  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else if (state.data == null) {
    body = LoadingView();
  } else {
    body = SmartRefresher(
      controller: state.refreshController,
      enablePullDown: false,
      enablePullUp: true,
      onLoading: () => dispatch(EssayDetailActionCreator.loadMore()),
      physics: const BouncingScrollPhysics(),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          viewService.buildComponent("content"),
          viewService.buildComponent("buttons"),
          Gap.makeSliverGap(height: 15),
          viewService.buildComponent("commentList"),
        ],
      ),
    );
  }
  return Scaffold(
    appBar: CustomNavigationBar(
      title: "详情",
    ),
    body: body,
    bottomNavigationBar: viewService.buildComponent('bottomBar'),
  );
}

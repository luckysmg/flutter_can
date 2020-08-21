import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/view/discover_detail_page/action.dart';
import 'package:neng/widgets/custom_html_widget.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'state.dart';

Widget buildView(
    DiscoverDetailState state, Dispatch dispatch, ViewService viewService) {
  if (state.hasNetworkError) {
    return Scaffold(
      appBar: CustomNavigationBar(),
      body: NetworkErrorView(
        onTapButton: () => dispatch(LifecycleCreator.initState()),
      ),
    );
  }

  ///内容布局
  var body;

  ///内容数据
  var detailData = state.detailData?.data ?? null;
  var commentsData = state.commentsData;
  if (detailData == null || commentsData == null) {
    body = LoadingView();
  } else {
    body = SmartRefresher(
      physics: BouncingScrollPhysics(),
      enablePullUp: state.commentsData.total > 10,
      enablePullDown: false,
      onLoading: () => dispatch(DiscoverDetailActionCreator.loadMore()),
      controller: state.refreshController,
      child: CustomScrollView(
        controller: state.scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(child: Gap.makeGap(height: 10)),

          ///标题
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                detailData.title,
                style: TextStyle(
                    fontSize: Constants.titleTextSize,
                    fontWeight: FontWeight.w500,
                    color: ColorUtil.mainTextColor),
              ),
            ),
          ),
          SliverToBoxAdapter(child: Gap.makeGap(height: 10)),

          ///作者，创建时间
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                //mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${detailData.createCommercialName}',
                    style: TextStyle(
                        color: ColorUtil.mainTextColor,
                        fontSize: Constants.secondTextSize,
                        fontWeight: FontWeight.w500),
                  ),
                  Gap.makeGap(width: 10),
                  Text(
                    '${detailData.createTime}',
                    style: TextStyle(
                        color: ColorUtil.auxiliaryTextColor,
                        fontSize: Constants.secondTextSize),
                  ),
                ],
              ),
            ),
          ),

          ///内容
          detailData.context != null
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomHtmlWidget(
                      data: detailData.context,
                    ),
                  ),
                )
              : SliverToBoxAdapter(),
          SliverToBoxAdapter(
              child: Gap.makeLineWithThickness(thicknessHeight: 10.0)),

          ///评论列表
          viewService.buildComponent('commentsList'),
        ],
      ),
    );
  }

  return Scaffold(
    bottomNavigationBar: state.commentsData == null
        ? Gap.empty
        : viewService.buildComponent('commentBox'),
    appBar: CustomNavigationBar(
      //backgroundColor: Colors.transparent,
      onTapTitle: () {
        state.scrollController.animateTo(0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linearToEaseOut);
      },
    ),
    resizeToAvoidBottomInset: false,
    body: AnimatedCrossFade(
      firstChild: LoadingView(),
      secondChild: body,
      crossFadeState: state.detailData == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
    ),
  );
}

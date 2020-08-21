import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:linked_scroll_widgets/linked_scroll_widgets.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/view/galaxy_detail_page/page.dart';
import 'package:neng/view/root_page/main_four_page/discover_page/action.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:neng/widgets/staus_bar_wrapper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'discover_list_component/action.dart';
import 'state.dart';

Widget buildView(
    DiscoverState state, Dispatch dispatch, ViewService viewService) {
  bool hasSettled = UserProfileUtil.isUserLogin() &&
      UserProfileUtil.getUserDetailInfo().galaxyName != null;

  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else if (state.tabCategoriesData == null) {
    body = LoadingView();
  } else {
    body = SmartRefresher(
        controller: state.refreshController,
        physics: const BouncingScrollPhysics(),
        enablePullDown: UserProfileUtil.getUserDetailInfo().galaxyName != null,
        enablePullUp: (state.discoverListData?.total ?? 0) != 0,
        onRefresh: () {
          dispatch(LifecycleCreator.initState());
          dispatch(DiscoverActionCreator.reload());
        },
        onLoading: () => dispatch(DiscoverListActionCreator.loadMore()),
        child: CustomScrollView(
            controller: state.scrollController,
            slivers: <Widget>[
              ///头部
              viewService.buildComponent("topHeader"),

              ///是否登陆并且定居？
              hasSettled

                  ///发现文章列表
                  ? viewService.buildComponent("discoverList")

                  ///选择星球的网格
                  : _buildNoSettledGrid(state, dispatch, viewService),
            ])).paddingBottom(MediaQuery.of(viewService.context)
            .padding
            .bottom +
        10);
  }

  return StatusBarWrapper(
    statusBarTextIsBlack: false,
    child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: LinkedOpacityNavigationBar(
        backgroundColor: ColorUtil.mainColor.withAlpha(240),
        scrollController: state.scrollController,
        middle: Text(UserProfileUtil.getUserDetailInfo().galaxyName ?? '发现星球')
            .withStyle(
                fontSize: Constants.secondTitleTextSize,
                color: ColorUtil.darkBackTextColor),
      ),
      body: body,
    ),
  );
}

///如果没有定居的时候显示的网格
Widget _buildNoSettledGrid(
    DiscoverState state, Dispatch dispatch, ViewService viewService) {
  return SliverPadding(
    padding: const EdgeInsets.only(top: 30),
    sliver: SliverGrid(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: <Widget>[
            LoadAssetImage(
              state.tabCategoriesData.rows[index].img,
              width: 60,
            ),
            Text(state.tabCategoriesData.rows[index].name),
          ],
        ).onTap(() {
          NavigatorUtil.push(
              context,
              GalaxyDetailPage().buildPage({
                'oid': state.tabCategoriesData.rows[index].oid,
                'title': state.tabCategoriesData.rows[index].name
              }),
              rootNavigator: true);
        });
      }, childCount: state.tabCategoriesData.rows.length),
    ),
  );
}

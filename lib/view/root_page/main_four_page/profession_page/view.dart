import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:linked_scroll_widgets/linked_scroll_widgets.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/view/root_page/main_four_page/profession_page/widgets/no_profession_view.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:neng/widgets/staus_bar_wrapper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'state.dart';
import 'widgets/no_login_view.dart';

Widget buildView(
    ProfessionState state, Dispatch dispatch, ViewService viewService) {
  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else if (!UserProfileUtil.isUserLogin()) {
    ///如果没登录，就显示去登陆页面
    body = NoLoginView();
  } else if (UserProfileUtil.getUserDetailInfo().professionName == null) {
    ///如果登陆了，但是用户没有选择职业显示选择职业
    body = NoProfessionView();
  } else if (state.homeClassListData == null) {
    body = LoadingView();
  } else {
    body = Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(viewService.context).padding.top,
          bottom: MediaQuery.of(viewService.context).padding.bottom),
      child: SmartRefresher(
        onRefresh: () => dispatch(LifecycleCreator.initState()),
        physics: const BouncingScrollPhysics(),
        controller: state.refreshController,
        child: CustomScrollView(
          controller: state.scrollController,
          slivers: <Widget>[
            Gap.makeSliverGap(height: 10),

            ///入门-进阶-高级-职业推荐
            viewService.buildComponent('recommendClassList'),

            ///推荐书籍
            viewService.buildComponent('recommendBookList'),

            ///推荐证书
            viewService.buildComponent('recommendCertificationList'),
          ],
        ),
      ),
    );
  }

  return StatusBarWrapper(
    child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: LinkedOpacityNavigationBar(
        scrollController: state.scrollController,
        middle: Text(UserProfileUtil.getUserDetailInfo().professionName ?? "职业")
            .withStyle(
                fontSize: Constants.secondTitleTextSize,
                color: ColorUtil.darkBackTextColor),
        backgroundColor: ColorUtil.mainColor.withAlpha(240),
      ),
      body: body,
    ),
  );
}

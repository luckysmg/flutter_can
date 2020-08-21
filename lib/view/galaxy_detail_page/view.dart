import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:linked_scroll_widgets/linked_scroll_widgets.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/dialog_util.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/widgets/back_icon_view.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:neng/widgets/staus_bar_wrapper.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GalaxyDetailState state, Dispatch dispatch, ViewService viewService) {
  ///是否是自己已经定居的星球 (已经登录并且galaxyCode存在且等于传来的oid)
  bool isOwnedGalaxy = UserProfileUtil.isUserLogin() &&
      UserProfileUtil.getUserDetailInfo().galaxyCode != null &&
      UserProfileUtil.getUserDetailInfo().galaxyCode == state.oid;

  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else {
    body = CustomScrollView(
      controller: state.scrollController,
      slivers: <Widget>[
        _buildTopHeader(state, dispatch, viewService, isOwnedGalaxy),
        viewService.buildComponent('list'),
      ],
    );
  }

  return StatusBarWrapper(
    statusBarTextIsBlack: false,
    child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(state, dispatch, viewService),
      body: body,
    ),
  );
}

///顶部appbar
Widget _buildAppBar(
    GalaxyDetailState state, Dispatch dispatch, ViewService viewService) {
  return Stack(
    alignment: Alignment.centerLeft,
    children: <Widget>[
      LinkedOpacityNavigationBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorUtil.mainColor.withAlpha(240),
        scrollController: state.scrollController,
        middle: Text(state.title).withStyle(
            fontSize: Constants.secondTitleTextSize,
            color: ColorUtil.darkBackTextColor),
      ),
      BackIconView(
        darkIcon: false,
      ).padding(top: MediaQuery.of(viewService.context).padding.top, left: 20),
    ],
  ).preferredSize(Size.fromHeight(44.0));
}

Widget _buildTopHeader(GalaxyDetailState state, Dispatch dispatch,
    ViewService viewService, bool isOwnedGalaxy) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: <Widget>[
      Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          LoadAssetImage(
            'ico_discover_bg',
            fit: BoxFit.contain,
          ),
          isOwnedGalaxy
              ? _buildSettledContent(state, dispatch, viewService)
              : _buildNoSettledContent(state, dispatch, viewService),
        ],
      ),

      ///圆角
      Container(
        height: 30,
        decoration: BoxDecoration(
          color: Theme.of(viewService.context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topRight: const Radius.circular(15),
              topLeft: const Radius.circular(15)),
        ),

        ///这里添加offset是为了避免锯齿
      ).offset(
        offset: Offset(0, 2),
      ),
    ],
  ).sliverBoxAdapter();
}

///是自己的定居星球时候的布局
Widget _buildSettledContent(
    GalaxyDetailState state, Dispatch dispatch, ViewService viewService) {
  return Row(
    children: <Widget>[
      ///名字和编号
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(state.title).withStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: Constants.titleTextSize),
          Gap.makeGap(height: 10),
        ],
      ),
    ],
  ).padding(left: 20, bottom: 30);
}

///没有定居的星球布局
Widget _buildNoSettledContent(
    GalaxyDetailState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Text(state.title).withStyle(
              fontSize: ScreenUtil().setSp(40),
              color: Colors.white,
              fontWeight: FontWeight.w500),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            height: 30,
            child: UserProfileUtil.isUserLogin()
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Gap.makeGap(width: 15),
                      Text("定居").withStyle(
                          color: ColorUtil.mainColor,
                          fontSize: Constants.secondTextSize),
                      Gap.makeGap(width: 15),
                    ],
                  ).onTap(() {
                    DialogUtil.showDialog(
                        context: viewService.context,
                        title: '是否移民到该星系？',
                        onConfirm: () {
                          Navigator.pop(viewService.context);
                          dispatch(GalaxyDetailActionCreator.settle());
                        });
                  })
                : Gap.empty,
          ),
        ],
      ),
      Gap.makeGap(height: 10),
    ],
  ).paddingSymmetric(horizontal: 20).paddingBottom(30);
}

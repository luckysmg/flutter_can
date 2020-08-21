import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/planet_info_page/page.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AllPlanetState state, Dispatch dispatch, ViewService viewService) {
  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else if (state.planetInGalaxyEntity == null) {
    body = LoadingView();
  } else {
    body = SmartRefresher(
      enablePullUp: true,
      onRefresh: () => dispatch(LifecycleCreator.initState()),
      onLoading: () => dispatch(AllPlanetActionCreator.loadMore()),
      physics: const BouncingScrollPhysics(),
      controller: state.refreshController,
      child: ListView.builder(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
          itemCount: state.planetInGalaxyEntity.rows.length,
          itemBuilder: (context, index) =>
              _item(state, dispatch, context, index)),
    );
  }

  return Scaffold(
    appBar: CustomNavigationBar(
      title: '所有行星',
    ),
    body: body,
  );
}

Widget _item(
    AllPlanetState state, Dispatch dispatch, BuildContext context, int index) {
  var itemData = state.planetInGalaxyEntity.rows[index];
  return Row(
    children: <Widget>[
      itemData.img == "NONE"
          ? LoadAssetImage(
              'default/pic_blank_planet',
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(100),
              fit: BoxFit.cover,
            )
          : SizedBox(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(100),
              child: CachedNetworkImage(
                fadeInDuration: const Duration(milliseconds: 200),
                imageUrl: itemData.img,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => LoadAssetImage(
                  'default/pic_blank_planet',
                  fit: BoxFit.cover,
                ),
              ),
            ),
      Gap.makeGap(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(itemData.title).withStyle(
              fontWeight: FontWeight.w500, fontSize: Constants.mainTextSize),
          Gap.makeGap(height: 5),
          Row(
            children: <Widget>[
              Text(itemData.nickName ?? "流浪者")
                  .withStyle(fontSize: Constants.secondTextSize),
              Gap.makeGap(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: ColorUtil.secondaryColor),
                child: Text('星主').withStyle(
                    color: ColorUtil.mainTextColor,
                    fontSize: Constants.auxiliaryTextSize),
              ),
            ],
          ),
          //Gap.makeGap(height: 10),
          Gap.line(),
        ],
      )
    ],
  ).paddingSymmetric(vertical: 5).onTap(() {
    NavigatorUtil.push(
        context,
        PlanetInfoPage().buildPage({
          'oid': itemData.oid,
          'galaxyOwnerName': itemData.nickName ?? "流浪者",
        }));
  }, hitTestBehavior: HitTestBehavior.opaque);
}

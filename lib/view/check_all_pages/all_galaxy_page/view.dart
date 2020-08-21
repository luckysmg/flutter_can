import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/galaxy_detail_page/page.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AllGalaxyState state, Dispatch dispatch, ViewService viewService) {
  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else if (state.galaxyCategoryData == null) {
    body = LoadingView();
  } else {
    body = SmartRefresher(
      enablePullUp: true,
      onRefresh: () => dispatch(LifecycleCreator.initState()),
      onLoading: () => dispatch(AllGalaxyActionCreator.loadMore()),
      physics: const BouncingScrollPhysics(),
      controller: state.refreshController,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        itemCount: state.galaxyCategoryData.rows.length,
        itemBuilder: (context, index) => _item(state, dispatch, context, index),
      ),
    );
  }

  return Scaffold(
    appBar: CustomNavigationBar(
      title: '所有星系',
    ),
    body: body,
  );
}

Widget _item(
    AllGalaxyState state, Dispatch dispatch, BuildContext context, int index) {
  var itemData = state.galaxyCategoryData.rows[index];
  return GestureDetector(
    onTap: () async {
      bool settled = false;
      settled = await NavigatorUtil.push(
          context,
          GalaxyDetailPage()
              .buildPage({'oid': itemData.oid, 'title': itemData.name}));
      if (settled) {
        Navigator.pop(context);
      }
    },
    behavior: HitTestBehavior.opaque,
    child: Container(
      height: 70,
      child: Row(
        children: <Widget>[
          LoadAssetImage(
            itemData.img,
            width: 65,
          ),
          Gap.makeGap(width: 10),
          Text(itemData.name,
              style: TextStyle(fontSize: Constants.mainTextSize)),
        ],
      ),
    ),
  );
}

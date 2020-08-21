import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/discover_detail_page/page.dart';
import 'package:neng/widgets/empty_view.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DiscoverCollectionState state, Dispatch dispatch, ViewService viewService) {
  if (state.hasNetworkError) {
    return NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  }

  if (state.data == null) {
    return LoadingView();
  }

  if (state.data.rows.length == 0) {
    return EmptyView(
      title: '还没有收藏哦',
    );
  }

  return SmartRefresher(
    physics: BouncingScrollPhysics(),
    enablePullUp: true,
    controller: state.refreshController,
    onRefresh: () => dispatch(LifecycleCreator.initState()),
    onLoading: () => dispatch(DiscoverCollectionActionCreator.loadMore()),
    child: ListView.builder(
        itemCount: state.data.rows.length,
        itemBuilder: (context, index) {
          return _item(state, dispatch, context, index);
        }),
  );
}

Widget _item(DiscoverCollectionState state, Dispatch dispatch,
    BuildContext context, int index) {
  var itemData = state.data.rows[index];
  return GestureDetector(
    onTap: () {
      NavigatorUtil.push(
          context,
          DiscoverDetailPage()
              .buildPage({'oid': state.data.rows[index].discoverOid}));
    },
    behavior: HitTestBehavior.opaque,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 0.6, color: ColorUtil.auxiliaryColor)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ///标题
                  Expanded(
                    child: Text(
                      itemData.discoverTitle,
                      style: TextStyle(fontSize: Constants.mainTextSize),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

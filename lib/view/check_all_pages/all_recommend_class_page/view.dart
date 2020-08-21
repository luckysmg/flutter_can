import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/class_detail_page/page.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AllRecommendClassState state, Dispatch dispatch, ViewService viewService) {
  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else if (state.classEntity == null) {
    body = LoadingView();
  } else {
    body = SmartRefresher(
      enablePullUp: true,
      onRefresh: () => dispatch(LifecycleCreator.initState()),
      onLoading: () => dispatch(AllRecommendClassActionCreator.loadMore()),
      physics: const BouncingScrollPhysics(),
      controller: state.refreshController,
      child: ListView.builder(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
          itemCount: state.classEntity.rows.length,
          itemBuilder: (context, index) =>
              _item(state, dispatch, context, index)),
    );
  }

  return Scaffold(
    appBar: CustomNavigationBar(
      title: state.title,
    ),
    body: body,
  );
}

Widget _item(AllRecommendClassState state, Dispatch dispatch,
    BuildContext context, int index) {
  var itemData = state.classEntity.rows[index];
  return GestureDetector(
    onTap: () => NavigatorUtil.push(
        context, ClassDetailPage().buildPage({'oid': itemData.oid}),
        rootNavigator: true),
    behavior: HitTestBehavior.opaque,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          ///图片
          Card(
            margin: const EdgeInsets.all(1),
            shape: const RoundedRectangleBorder(
              //形状
              //修改圆角
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            //阴影高度
            elevation: 1.0,
            child: SizedBox(
              width: 150,
              child: ClipRRect(
                child: CachedNetworkImage(
                  fadeInDuration: const Duration(milliseconds: 100),
                  fit: BoxFit.fitHeight,
                  imageUrl: itemData.imageUrl,
                  errorWidget: (_, __, ___) => LoadAssetImage(
                    'none',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          Gap.makeGap(width: 10),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ///课程名字
                SizedBox(
                  height: 50,
                  child: Text(itemData.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: Constants.mainTextSize,
                          color: ColorUtil.mainTextColor,
                          fontWeight: FontWeight.w500)),
                ),
                Text('${itemData.commercialName}, ${itemData.periods}课时',
                    style: TextStyle(
                        fontSize: Constants.auxiliaryTextSize,
                        color: ColorUtil.auxiliaryTextColor)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      itemData.discountPrice == '0.00'
                          ? '免费'
                          : itemData.discountPrice,
                      style: TextStyle(
                          fontSize: Constants.mainTextSize,
                          color: ColorUtil.redColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

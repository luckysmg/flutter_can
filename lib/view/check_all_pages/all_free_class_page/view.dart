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
    AllFreeClassState state, Dispatch dispatch, ViewService viewService) {
  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else if (state.freeClassData == null) {
    body = LoadingView();
  } else {
    body = SmartRefresher(
      enablePullUp: true,
      onRefresh: () => dispatch(LifecycleCreator.initState()),
      onLoading: () => dispatch(AllFreeClassActionCreator.loadMore()),
      physics: BouncingScrollPhysics(),
      controller: state.refreshController,
      child: ListView.builder(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
          itemCount: state.freeClassData.rows.length,
          itemBuilder: (context, index) =>
              _item(state, dispatch, context, index)),
    );
  }

  return Scaffold(
    appBar: CustomNavigationBar(
      title: '免费课程',
    ),
    body: body,
  );
}

Widget _item(AllFreeClassState state, Dispatch dispatch, BuildContext context,
    int index) {
  var itemData = state.freeClassData.rows[index];
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
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: CachedNetworkImage(
                fadeInDuration: const Duration(milliseconds: 100),
                fit: BoxFit.fitHeight,
                imageUrl: itemData.imageUrl,
                errorWidget: (_, __, ___) => LoadAssetImage(
                  'default/pic_blank_curriculum',
                  fit: BoxFit.fitWidth,
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
                          color: ColorUtil.mainTextColor,
                          fontSize: Constants.mainTextSize)),
                ),
                Text('${itemData.commercialName}, ${itemData.periods}课时',
                    style: TextStyle(
                        color: ColorUtil.auxiliaryTextColor,
                        fontSize: Constants.auxiliaryTextSize)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      itemData.discountPrice == '0.00'
                          ? '免费'
                          : itemData.discountPrice,
                      style: TextStyle(
                          color: ColorUtil.redColor,
                          fontSize: Constants.mainTextSize),
                    ),
                    Gap.makeGap(width: 10),
                    Text(
                      "¥" + itemData.price,
                      style: Constants.lineThroughTextStyle,
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/discover_detail_page/page.dart';
import 'package:neng/widgets/empty_view.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/loading_view.dart';

import 'state.dart';

Widget buildView(
    DiscoverListState state, Dispatch dispatch, ViewService viewService) {
  if (state.discoverListData == null) {
    return SliverToBoxAdapter(
      child: LoadingView(),
    );
  }
  if (state.discoverListData.total == 0) {
    return SliverToBoxAdapter(child: EmptyView());
  }

  return SliverToBoxAdapter(
    child: ListView.builder(
        padding: const EdgeInsets.only(),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _item(state, viewService, index),
        itemCount: state.discoverListData.rows.length),
  );
}

Widget _item(DiscoverListState state, ViewService viewService, int index) {
  var itemData = state.discoverListData.rows[index];
  String monthStr = itemData.createTime.substring(5, 7);
  String dayStr = itemData.createTime.substring(8, 10);
  int month = int.parse(monthStr);
  int day = int.parse(dayStr);

  return GestureDetector(
    onTap: () {
      NavigatorUtil.push(viewService.context,
          DiscoverDetailPage().buildPage({'oid': itemData.oid}),
          rootNavigator: true);
    },
    child: Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 0.6, color: ColorUtil.auxiliaryColor)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: <Widget>[
          ///左边
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ///标题
                Expanded(
                  child: Container(
                      child: Text(
                    itemData.title,
                    style: TextStyle(fontSize: Constants.mainTextSize),
                    strutStyle: StrutStyle(leading: 0.5),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                ),

                ///作者
                Row(
                  children: <Widget>[
                    Text(
                      '${itemData.createCommercialName}',
                      style: TextStyle(
                          fontSize: Constants.auxiliaryTextSize,
                          color: ColorUtil.mainTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Gap.makeGap(width: 10),

                    ///信息
                    Text(
                      '$month月$day日',
                      style: TextStyle(
                          fontSize: Constants.auxiliaryTextSize,
                          color: ColorUtil.auxiliaryTextColor),
                    ),
                  ],
                )
              ],
            ),
          ),
          Gap.makeGap(width: 10),

          ///图片
          ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 100),
              fit: BoxFit.cover,
              width: 100,
              height: 100,
              imageUrl: itemData.imageUrl ?? "",
              placeholder: (_, __) => LoadAssetImage(
                'default/pic_blank_discover',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              errorWidget: (_, __, ___) => LoadAssetImage(
                'default/pic_blank_discover',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),

          ///end
        ],
      ),
    ),
  );
}

//Widget _header(
//    DiscoverListState state, Dispatch dispatch, ViewService viewService) {
//  var left = Text('综合排序',
//      style: TextStyle(
//          fontSize: ScreenUtil().setSp(30), fontWeight: FontWeight.w500));
//
//  var right = PopupWindowButton<List>(
//    onPop: (t) {
//      TipUtil.show(context: viewService.context, message: t.toString());
//    },
//    window: _windowView(state, dispatch, viewService),
//    child: Row(
//      children: <Widget>[
//        Text('全部', style: TextStyle(fontSize: ScreenUtil().setSp(30))),
//        Icon(
//          Icons.arrow_drop_down,
//          size: ScreenUtil().setSp(36),
//        ),
//        Gap.makeGap(width: 15),
//      ],
//    ),
//  );
//
//  return Padding(
//    padding: const EdgeInsets.only(left: 15, top: 10),
//    child: Row(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//      children: <Widget>[
//        left,
//        right,
//      ],
//    ),
//  );
//}
//
////Widget _windowView(
////    DiscoverListState state, Dispatch dispatch, ViewService viewService) {
////  return DiscoverListFilterWindowView();
////}

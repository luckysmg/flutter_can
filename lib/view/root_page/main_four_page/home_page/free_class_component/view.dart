import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/check_all_pages/all_free_class_page/page.dart';
import 'package:neng/view/class_detail_page/page.dart';
import 'package:neng/view/root_page/main_four_page/home_page/widgets/home_group_header.dart';
import 'package:neng/widgets/load_asset_image.dart';

import '../state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  return SliverPadding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
    sliver: state.freeClassData == null
        ? Gap.makeSliverGap()
        : SliverStickyHeader(
            header: HomeGroupHeader(
              text: '免费课程',
              onTap: () => NavigatorUtil.push(
                  viewService.context, AllFreeClassPage().buildPage(null),
                  rootNavigator: true),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _item(state, dispatch, context, index),
                  childCount: state.freeClassData.rows.length <= 5
                      ? state.freeClassData.rows.length
                      : 5),
            ),
          ),
  );
}

Widget _item(
    HomeState state, Dispatch dispatch, BuildContext context, int index) {
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
                  placeholder: (_, __) => LoadAssetImage(
                    'default/pic_blank_curriculum',
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (_, __, ___) => LoadAssetImage(
                      'default/pic_blank_curriculum',
                      width: 150,
                      fit: BoxFit.cover),
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

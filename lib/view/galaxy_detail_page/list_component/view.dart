import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/discover_detail_page/page.dart';
import 'package:neng/widgets/empty_view.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/loading_view.dart';

import '../state.dart';

Widget buildView(
    GalaxyDetailState state, Dispatch dispatch, ViewService viewService) {
  if (state.discoverListData == null) {
    return LoadingView().sliverBoxAdapter();
  }
  if (state.discoverListData.total == 0) {
    return EmptyView().sliverBoxAdapter();
  }

  return SliverList(
    delegate: SliverChildBuilderDelegate((context, index) {
      return _item(state, dispatch, context, index);
    }, childCount: state.discoverListData.rows.length),
  );
}

Widget _item(GalaxyDetailState state, Dispatch dispatch, BuildContext context,
    int index) {
  var itemData = state.discoverListData.rows[index];
  String monthStr = itemData.createTime.substring(5, 7);
  String dayStr = itemData.createTime.substring(8, 10);
  int month = int.parse(monthStr);
  int day = int.parse(dayStr);

  return GestureDetector(
    onTap: () {
      NavigatorUtil.push(
          context, DiscoverDetailPage().buildPage({'oid': itemData.oid}),
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

                ///信息
                Text(
                  '${itemData.createCommercialName}    $month月$day日',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      fontWeight: FontWeight.w500,
                      color: ColorUtil.auxiliaryTextColor),
                ),
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
                  fit: BoxFit.cover),
            ),
          ),

          ///end
        ],
      ),
    ),
  );
}

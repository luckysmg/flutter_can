import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/class_detail_page/page.dart';
import 'package:neng/widgets/empty_view.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ClassCollectionState state, Dispatch dispatch, ViewService viewService) {
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
    onLoading: () => dispatch(ClassCollectionActionCreator.loadMore()),
    child: ListView.builder(
        itemCount: state.data.rows.length,
        itemBuilder: (context, index) {
          return _item(state, dispatch, context, index);
        }),
  );
}

Widget _item(ClassCollectionState state, Dispatch dispatch,
    BuildContext context, int index) {
  var itemData = state.data.rows[index];
  return GestureDetector(
    onTap: () {
      NavigatorUtil.push(
          context,
          ClassDetailPage()
              .buildPage({'oid': state.data.rows[index].curriculumOid}));
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
          ///这个是发现收藏页面item图片位置，课程收藏没图片
//          Container(
//            height: 75,
//            width: 100,
//            child: ClipRRect(
//              borderRadius: BorderRadius.circular(0),
//              child: CachedNetworkImage(
//                imageUrl: API.imageUrlHeader + itemData.c,
//                fit: BoxFit.fitHeight,
//                errorWidget: (_, __, ___) => LoadAssetImage(
//                  'none',
//                  fit: BoxFit.fitWidth,
//                ),
//              ),
//            ),
//          ),
          Gap.makeGap(width: 10),
          Expanded(
            child: Container(
              height: 75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ///标题
                  Expanded(
                    child: Text(
                      itemData.curriculumTitle,
                      style: TextStyle(fontSize: Constants.mainTextSize),
                      maxLines: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            itemData.curriculumCommercialName,
                            style: TextStyle(
                                fontSize: Constants.secondTextSize,
                                color: ColorUtil.mainTextColor),
                          ),
                          Gap.makeGap(width: 10),
                          Text(
                            itemData.curriculumDiscountPrice,
                            style: TextStyle(
                                fontSize: Constants.secondTextSize,
                                color: ColorUtil.redColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Gap.makeGap(width: 5),
                          Text(
                            itemData.curriculumPrice,
                            style: Constants.lineThroughTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),

                  ///价格
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

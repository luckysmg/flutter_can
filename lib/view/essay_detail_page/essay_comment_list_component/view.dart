import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/widgets/default_head_view.dart';

import '../state.dart';

Widget buildView(
    EssayDetailState state, Dispatch dispatch, ViewService viewService) {
  if (state.commentListData.total == 0) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, left: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text('评论区',
                style: TextStyle(
                    fontSize: Constants.secondTitleTextSize,
                    color: ColorUtil.mainTextColor,
                    fontWeight: FontWeight.w500)),
            Gap.makeGap(width: 5),
            Text('${state.commentListData.total}',
                style: TextStyle(
                  fontSize: Constants.auxiliaryTextSize,
                  color: ColorUtil.mainTextColor,
                )),
          ],
        ),
      ),
    );
  }
  return SliverToBoxAdapter(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Gap.makeLineWithThickness(thicknessHeight: 4),
        _header(state, dispatch, viewService),
        Gap.makeGap(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
              padding: const EdgeInsets.only(),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.commentListData.rows.length,
              itemBuilder: (ctx, index) {
                return _item(state, dispatch, ctx, index);
              }),
        ),
      ],
    ),
  );
}

Widget _header(
    EssayDetailState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: Padding(
      padding: EdgeInsets.only(top: 10.0, left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text('评论区',
              style: TextStyle(
                  fontSize: Constants.secondTitleTextSize,
                  color: ColorUtil.mainTextColor,
                  fontWeight: FontWeight.w500)),
          Gap.makeGap(width: 5),
          Text('${state.commentListData.total}',
              style: TextStyle(
                fontSize: Constants.auxiliaryTextSize,
                color: ColorUtil.mainTextColor,
              )),
        ],
      ),
    ),
  );
}

Widget _item(EssayDetailState state, Dispatch dispatch, BuildContext context,
    int index) {
  var itemData = state.commentListData.rows[index];
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ///头像
        SizedBox(
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              imageUrl: '${itemData.headImageUrl}',
              placeholder: (_, __) => DefaultHeadView(
                width: 40,
              ),
              errorWidget: (_, __, ___) => DefaultHeadView(
                width: 40,
              ),
            ),
          ),
        ),
        Gap.makeGap(width: 10),

        ///头像右边的
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ///名字
              Text(
                itemData.nickName ?? '流浪者',
                style: TextStyle(
                    fontSize: Constants.mainTextSize,
                    fontWeight: FontWeight.w500,
                    color: ColorUtil.mainTextColor),
              ),

              Gap.makeGap(height: 5),

              ///内容
              Text(itemData.descript,
                  style: TextStyle(
                      fontSize: Constants.mainTextSize,
                      color: ColorUtil.mainTextColor)),
              Gap.makeGap(height: 5),

              ///时间
              Text(itemData.createTime,
                  style: TextStyle(
                      color: ColorUtil.auxiliaryTextColor,
                      fontSize: Constants.secondTextSize)),
            ],
          ),
        ),
      ],
    ),
  );
}

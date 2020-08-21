import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/widgets/default_head_view.dart';

import 'state.dart';

Widget buildView(
    CommentListState state, Dispatch dispatch, ViewService viewService) {
  if (state.commentsData.total == 0) {
    return SliverToBoxAdapter(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text('暂时还没有评论哦',
            style: TextStyle(
                fontSize: Constants.auxiliaryTextSize,
                color: ColorUtil.auxiliaryTextColor)),
      )),
    );
  }
  return SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _header(state, dispatch, viewService),
          Gap.makeGap(height: 10),
          ListView.builder(
              padding: const EdgeInsets.only(),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.commentsData.rows.length,
              itemBuilder: (ctx, index) {
                return _item(state, dispatch, ctx, index);
              }),
        ],
      ),
    ),
  );
}

Widget _header(
    CommentListState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text('评论区',
              style: TextStyle(
                  fontSize: Constants.secondTitleTextSize,
                  color: ColorUtil.mainTextColor,
                  fontWeight: FontWeight.w500)),
          Gap.makeGap(width: 5),
          Text(
            '${state.commentsData.total}',
            style: TextStyle(
              fontSize: Constants.auxiliaryTextSize,
              color: ColorUtil.mainTextColor,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _item(
    CommentListState state, Dispatch dispatch, BuildContext ctx, int index) {
  var itemData = state.commentsData.rows[index];
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
                itemData.nickName ?? "流浪者",
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

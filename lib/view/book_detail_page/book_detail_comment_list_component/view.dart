import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/widgets/empty_view.dart';

import '../../../widgets/default_head_view.dart';

import 'state.dart';

Widget buildView(BookDetailCommentListState state, Dispatch dispatch,
    ViewService viewService) {
  var emptyView = Center(
      child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: EmptyView(
      title: '暂无评论',
    ),
  ));
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gap.makeGap(height: 20),
          _header(state, dispatch, viewService),
          state.commentsData.total == 0 ? emptyView : Gap.makeGap(height: 10),
          ListView.builder(
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

Widget _header(BookDetailCommentListState state, Dispatch dispatch,
    ViewService viewService) {
  return Container(
    child: Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text('评论区',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: ColorUtil.mainTextColor,
                  fontSize: Constants.secondTitleTextSize)),
          Gap.makeGap(width: 5),
          Text('${state.commentsData.total}',
              style: TextStyle(
                  color: ColorUtil.mainTextColor,
                  fontSize: Constants.auxiliaryTextSize)),
        ],
      ),
    ),
  );
}

Widget _item(BookDetailCommentListState state, Dispatch dispatch,
    BuildContext ctx, int index) {
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
                itemData.nickName ?? "流浪者",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorUtil.secondaryTextColor),
              ),

              Gap.makeGap(height: 5),

              ///内容
              Text(itemData.descript,
                  style: TextStyle(color: ColorUtil.mainTextColor)),
              Gap.makeGap(height: 5),

              ///时间
              Text(itemData.createTime,
                  style: TextStyle(
                      color: ColorUtil.auxiliaryTextColor,
                      fontSize: Constants.auxiliaryTextSize)),
            ],
          ),
        ),
      ],
    ),
  );
}

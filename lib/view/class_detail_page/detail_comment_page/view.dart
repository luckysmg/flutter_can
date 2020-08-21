import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/view/class_detail_page/detail_comment_page/action.dart';
import 'package:neng/widgets/bottom_bar.dart';
import 'package:neng/widgets/default_head_view.dart';
import 'package:neng/widgets/empty_view.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/need_login_click_wrapper.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'state.dart';

Widget buildView(
    DetailCommentState state, Dispatch dispatch, ViewService viewService) {
  if (state.hasNetworkError) {
    return NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  }
  if (state.commentListData == null) {
    return LoadingView();
  }

  return Stack(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(viewService.context).padding.bottom +
                kToolbarHeight),
        child: SmartRefresher(
          physics: BouncingScrollPhysics(),
          controller: state.refreshController,
          enablePullUp: state.commentListData.total > 0,
          enablePullDown: false,
          onLoading: () {
            dispatch(DetailCommentActionCreator.loadMore());
          },
          child: CustomScrollView(
            slivers: [
              ///列表
              state.commentListData.total == 0
                  ? SliverToBoxAdapter(
                      child: EmptyView(
                      title: '暂无评论',
                    ))
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            _item(state, dispatch, context, index),
                        childCount: state.commentListData.rows.length,
                      ),
                    )
            ],
          ),
        ),
      ),
      Positioned(
          bottom: 0,
          child: NeedLoginClickWrapper(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: viewService.context,
                  builder: (context) {
                    return _inputBoxView(context, dispatch, state);
                  });
            },
            child: BottomBar(
              child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 40,
                  decoration: BoxDecoration(
                      color: ColorUtil.auxiliaryColor,
                      borderRadius: BorderRadius.circular(2)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('我来说两句',
                        style: TextStyle(fontWeight: FontWeight.w300)),
                  )),
            ),
          )),
    ],
  );
}

Widget _inputBoxView(
  BuildContext context,
  Dispatch dispatch,
  DetailCommentState state,
) {
  var cancelStyle = TextStyle(
    color: ColorUtil.secondaryTextColor,
    fontSize: Constants.mainTextSize,
  );

  var publishStyle = TextStyle(
    color: ColorUtil.mainColor,
    fontSize: Constants.mainTextSize,
  );
  var header = Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
            onTap: () async {
              state.focusNode.unfocus();
              Navigator.pop(context);
            },
            child: Text('取消', style: cancelStyle)),
        GestureDetector(
            onTap: () => dispatch(DetailCommentActionCreator.comment()),
            child: Text('发布', style: publishStyle)),
      ],
    ),
  );

  var inputBox = Container(
    height: 120,
    width: ScreenUtil.screenWidthDp,
    child: TextField(
      autofocus: true,
      style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colors.black87),
      maxLines: 20,
      focusNode: state.focusNode,
      scrollPhysics: BouncingScrollPhysics(),
      controller: state.textEditingController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 16, right: 16, top: 10),
        hintText: '写下你的评论',
        border: InputBorder.none,
      ),
    ),
  );
  return Container(
    height: MediaQuery.of(context).viewInsets.bottom + 200,
    width: ScreenUtil.screenWidthDp,
    child: Material(
      child: Column(
        children: <Widget>[
          header,
          Gap.line(),
          inputBox,
        ],
      ),
    ),
  );
}

Widget _item(DetailCommentState state, Dispatch dispatch, BuildContext context,
    int index) {
  var itemData = state.commentListData.rows[index];
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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

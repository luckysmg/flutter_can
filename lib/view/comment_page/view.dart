import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CommentState state, Dispatch dispatch, ViewService viewService) {
  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else {
    body = SmartRefresher(
      physics: BouncingScrollPhysics(),
      enablePullUp: true,
      onRefresh: () => dispatch(CommentActionCreator.init()),
      onLoading: () => dispatch(CommentActionCreator.loadMore()),
      controller: state.refreshController,
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) =>
              _item(state, dispatch, context, index)),
    );
  }

  return Scaffold(
    appBar: CustomNavigationBar(
      title: '评论',
    ),
    body: body,
  );
}

Widget _item(state, Dispatch dispatch, BuildContext context, int index) {
  return Container();
}

//Widget _item(
//    CommentState state, Dispatch dispatch, BuildContext ctx, int index) {
//  var itemData = state.commentsData.rows[index];
//  return Padding(
//    padding: EdgeInsets.symmetric(vertical: 10),
//    child: Row(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        ///头像
//        ClipRRect(
//          borderRadius: BorderRadius.circular(30),
//          child: CachedNetworkImage(
//            imageUrl: itemData.headImageUrl,
//            height: 40,
//          ),
//        ),
//        Gap.makeGap(width: 10),
//
//        ///头像右边的
//        Expanded(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              ///名字
//              Text(
//                itemData.userName,
//                style: TextStyle(
//                    fontWeight: FontWeight.w500, color: Colors.black38),
//              ),
//
//              Gap.makeGap(height: 5),
//
//              ///内容
//              Text(itemData.descript,
//                  style: TextStyle(
//                      fontWeight: FontWeight.w300, color: Colors.black87)),
//              Gap.makeGap(height: 5),
//
//              ///时间
//              Text(itemData.createTime,
//                  style: TextStyle(
//                      fontWeight: FontWeight.w300,
//                      color: Constants.secondaryFontColor,
//                      fontSize: ScreenUtil().setSp(28))),
//            ],
//          ),
//        ),
//      ],
//    ),
//  );
//}

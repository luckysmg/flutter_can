import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:neng/entity/comment_list_entity.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';

import 'action.dart';
import 'state.dart';

Effect<DetailCommentState> buildEffect() {
  return combineEffects(<Object, Effect<DetailCommentState>>{
    Lifecycle.initState: _init,
    DetailCommentAction.init: _init,
    DetailCommentAction.loadMore: _loadMore,
    DetailCommentAction.comment: _comment,
  });
}

void _init(Action action, Context<DetailCommentState> ctx) {
  ctx.state.currentPage = 1;
  DioUtil.getInstance().doPost<CommentListEntity>(
      url: API.comment_search,
      context: ctx.context,
      param: {
        'size': 10,
        'page': ctx.state.currentPage,
        'bid': ctx.state.oid,
        'type': 'CURRICULUM'
      },
      onSuccess: (data) {
        ctx.state.hasNetworkError = false;
        ctx.state.commentListData = data;
        PageUtil.updateAfterInitOrRefresh(
            controller: ctx.state.refreshController,
            responseDataCount: data.rows.length,
            totalCount: data.total);
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });
}

void _loadMore(Action action, Context<DetailCommentState> ctx) {
  DioUtil.getInstance().doPost<CommentListEntity>(
      url: API.comment_search,
      context: ctx.context,
      needDelay: true,
      delayMills: Constants.delayLoadMore,
      param: {
        'size': 10,
        'page': ctx.state.currentPage + 1,
        'bid': ctx.state.oid,
        'type': 'CURRICULUM'
      },
      onSuccess: (data) {
        ctx.state.currentPage++;
        ctx.state.hasNetworkError = false;
        ctx.state.commentListData.rows.addAll(data.rows);
        ctx.dispatch(DetailCommentActionCreator.update());
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: ctx.state.commentListData.rows.length,
            totalCount: data.total);
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

void _comment(Action action, Context<DetailCommentState> ctx) {
  if (ctx.state.textEditingController.text == null ||
      ctx.state.textEditingController.text.isEmpty) {
    return;
  }

  ///评论
  DioUtil.getInstance().doPost<SimpleEntity>(
      url: API.add_comment,
      context: ctx.context,
      param: {
        'bid': ctx.state.oid,
        'type': 'CURRICULUM',
        'descript': ctx.state.textEditingController.text,
      },
      onSuccess: (data) async {
        ctx.state.focusNode.unfocus();

        ///清空输入框文本
        ctx.state.textEditingController.text = '';

        ///刷新评论
        ctx.dispatch(DetailCommentActionCreator.init());
        Navigator.pop(ctx.context);
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

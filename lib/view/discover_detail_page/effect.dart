import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/comment_list_entity.dart';
import 'package:neng/entity/discover_item_detail_entity.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/material.dart' as m;
import 'package:neng/util/toast_util.dart';

import 'action.dart';
import 'state.dart';

Effect<DiscoverDetailState> buildEffect() {
  return combineEffects(<Object, Effect<DiscoverDetailState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _dispose,
    DiscoverDetailAction.reload: _onInit,
    DiscoverDetailAction.onAddComment: _onAddComment,
    DiscoverDetailAction.onRefreshCommentList: _onRefreshCommentList,
    DiscoverDetailAction.scrollToComment: _scrollToComment,
    DiscoverDetailAction.loadMore: _loadMore,
  });
}

void _dispose(Action action, Context<DiscoverDetailState> ctx) {
  ctx.state.scrollController?.dispose();
}

void _scrollToComment(Action action, Context<DiscoverDetailState> ctx) {
  Duration duration = const Duration(milliseconds: 300);
  var extraOffset = ctx.state.commentsData.total == 0 ? 0 : -30;

  m.Curve curve = m.Curves.decelerate;
  ctx.state.scrollController.animateTo(
      ctx.state.scrollController.position.maxScrollExtent + extraOffset,
      duration: duration,
      curve: curve);
}

void _onInit(Action action, Context<DiscoverDetailState> ctx) async {
  DiscoverItemDetailEntity detailData;
  CommentListEntity commentsData;
  var getDetail = DioUtil.getInstance().doPost<DiscoverItemDetailEntity>(
      url: API.discover_item_detail + "/${ctx.state.oid}",
      context: ctx.context,
      needDelay: true,
      onSuccess: (data) async {
        ctx.state.hasNetworkError = false;
        detailData = data;
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
        ctx.dispatch(DiscoverDetailActionCreator.update());
      });

  var getCommentsList = DioUtil.getInstance().doPost<CommentListEntity>(
      url: API.comment_search,
      param: {
        'size': 10,
        'page': 1,
        'type': 'DISCOVER',
        'bid': ctx.state.oid,
      },
      context: ctx.context,
      onSuccess: (data) async {
        commentsData = data;
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });

  await Future.wait([getDetail, getCommentsList]);
  ctx.dispatch(DiscoverDetailActionCreator.init({
    'detailData': detailData,
    'commentsData': commentsData,
  }));
}

void _onAddComment(Action action, Context<DiscoverDetailState> ctx) {
  if (ctx.state.textEditingController.text.isNotEmpty) {
    DioUtil.getInstance().doPost<SimpleEntity>(
        url: API.add_comment,
        context: ctx.context,
        param: {
          'bid': ctx.state.oid,
          'type': 'DISCOVER',
          'descript': ctx.state.textEditingController.text,
        },
        onSuccess: (data) async {
          ctx.dispatch(DiscoverDetailActionCreator.onRefreshCommentList());
          ctx.state.textEditingController.text = '';
          ctx.state.focusNode.unfocus();
          Navigator.pop(ctx.context);
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }
}

void _onRefreshCommentList(Action action, Context<DiscoverDetailState> ctx) {
  ctx.state.currentPage = 1;
  DioUtil.getInstance().doPost<CommentListEntity>(
      url: API.comment_search,
      param: {
        'size': 10,
        'page': ctx.state.currentPage,
        'type': 'DISCOVER',
        'bid': ctx.state.oid,
      },
      context: ctx.context,
      onSuccess: (data) async {
        ctx.state.hasNetworkError = false;
        ctx.dispatch(DiscoverDetailActionCreator.refreshCommentList(data));
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });
}

void _loadMore(Action action, Context<DiscoverDetailState> ctx) {
  DioUtil.getInstance().doPost<CommentListEntity>(
      url: API.comment_search,
      needDelay: true,
      param: {
        'size': 10,
        'page': ctx.state.currentPage + 1,
        'type': 'DISCOVER',
        'bid': ctx.state.oid,
      },
      context: ctx.context,
      onSuccess: (data) async {
        ctx.state.currentPage++;
        ctx.state.hasNetworkError = false;
        ctx.state.commentsData.rows.addAll(data.rows);
        ctx.dispatch((DiscoverDetailActionCreator.update()));
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: ctx.state.commentsData.rows.length,
            totalCount: data.total);
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

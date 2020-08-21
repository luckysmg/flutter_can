import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' as m;
import 'package:neng/entity/certification_detail_entity.dart';
import 'package:neng/entity/comment_list_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';

import 'action.dart';
import 'state.dart';

Effect<CertificateDetailState> buildEffect() {
  return combineEffects(<Object, Effect<CertificateDetailState>>{
    Lifecycle.initState: _init,
    CertificateDetailAction.init: _init,
    CertificateDetailAction.loadMore: _loadMore,
    CertificateDetailAction.refreshCommentList: _refreshCommentList,
    CertificateDetailAction.scrollToComment: _scrollToComment,
    CertificateDetailAction.switchSchedulesIndex: _switchSchedulesIndex,
  });
}

void _switchSchedulesIndex(Action action, Context<CertificateDetailState> ctx) {
  int currentSchedulesIndex = action.payload;
  ctx.state.currentIndex = currentSchedulesIndex;
  ctx.dispatch(CertificateDetailActionCreator.update());
}

void _scrollToComment(Action action, Context<CertificateDetailState> ctx) {
  Duration duration = const Duration(milliseconds: 300);
  var extraOffset = ctx.state.commentsData.total == 0 ? 0 : -30;

  m.Curve curve = m.Curves.decelerate;
  ctx.state.scrollController.animateTo(
      ctx.state.scrollController.position.maxScrollExtent + extraOffset,
      duration: duration,
      curve: curve);
}

void _init(Action action, Context<CertificateDetailState> ctx) async {
  ctx.state.currentPage = 1;
  var getDetailData = DioUtil.getInstance().doPost<CertificationDetailEntity>(
      url: API.certification_detail + '/${ctx.state.oid}',
      context: ctx.context,
      needDelay: true,
      param: {'oid': ctx.state.oid},
      onSuccess: (data) {
        ctx.state.dataHasResp = true;
        ctx.state.hasNetworkError = false;
        ctx.state.detailData = data;
      },
      onFailure: (e) {
        ctx.state.dataHasResp = true;
        PageUtil.initFail(ctx, e);
      });

  var getCommentsData = DioUtil.getInstance().doPost<CommentListEntity>(
      url: API.comment_search,
      param: {
        'size': 10,
        'page': 1,
        'type': 'CERTIFICATION',
        'bid': ctx.state.oid,
      },
      context: (ctx.context),
      onSuccess: (data) {
        ctx.state.dataHasResp = true;
        ctx.state.commentsData = data;
        ctx.state.hasNetworkError = false;
      },
      onFailure: (e) {
        ctx.state.dataHasResp = true;
        ToastUtil.show(e.msg);
      });

  await Future.wait([getDetailData, getCommentsData]);
  ctx.dispatch((CertificateDetailActionCreator.update()));
}

void _loadMore(Action action, Context<CertificateDetailState> ctx) {
  DioUtil.getInstance().doPost<CommentListEntity>(
      url: API.comment_search,
      needDelay: true,
      param: {
        'size': 10,
        'page': ctx.state.currentPage + 1,
        'type': 'CERTIFICATION',
        'bid': ctx.state.oid,
      },
      context: ctx.context,
      onSuccess: (data) {
        ctx.state.currentPage++;
        ctx.state.hasNetworkError = false;
        ctx.state.commentsData.rows.addAll(data.rows);
        ctx.dispatch((CertificateDetailActionCreator.update()));
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: ctx.state.commentsData.rows.length,
            totalCount: data.total);
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

void _refreshCommentList(Action action, Context<CertificateDetailState> ctx) {
  ctx.state.currentPage = 1;
  DioUtil.getInstance().doPost<CommentListEntity>(
      url: API.comment_search,
      param: {
        'size': 10,
        'page': ctx.state.currentPage,
        'type': 'CERTIFICATION',
        'bid': ctx.state.oid,
      },
      context: ctx.context,
      onSuccess: (data) async {
        ctx.state.hasNetworkError = false;
        ctx.state.commentsData = data;
        ctx.dispatch(CertificateDetailActionCreator.update());
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });
}

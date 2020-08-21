import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/book_detail_entity.dart';
import 'package:neng/entity/comment_list_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/toast_util.dart';
import 'action.dart';
import 'state.dart';

Effect<BookDetailState> buildEffect() {
  return combineEffects(<Object, Effect<BookDetailState>>{
    Lifecycle.initState: _init,
    BookDetailAction.init: _init,
    BookDetailAction.loadMore: _loadMore,
  });
}

void _init(Action action, Context<BookDetailState> ctx) async {
  var state = ctx.state;
  state.currentPage = 1;
  var getDetailData = DioUtil.getInstance().doPost<BookDetailEntity>(
      url: API.book_detail + '/${state.oid}',
      context: ctx.context,
      needDelay: true,
      onSuccess: (data) {
        ctx.state.hasNetworkError = false;
        state.bookDetailData = data;
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });

  var getCommentData = DioUtil.getInstance().doPost<CommentListEntity>(
      url: API.comment_search,
      context: ctx.context,
      param: {
        'size': 10,
        'page': state.currentPage,
        'type': 'BOOK',
        'bid': state.oid,
      },
      onSuccess: (data) {
        state.commentsData = data;
        PageUtil.updateAfterInitOrRefresh(
            controller: state.refreshController,
            responseDataCount: data.rows.length,
            totalCount: data.total);
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });

  await Future.wait([getDetailData, getCommentData]);
  ctx.dispatch(BookDetailActionCreator.update());
}

void _loadMore(Action action, Context<BookDetailState> ctx) {
  var state = ctx.state;
  DioUtil.getInstance().doPost<CommentListEntity>(
      url: API.comment_search,
      context: ctx.context,
      needDelay: true,
      delayMills: Constants.delayLoadMore,
      param: {
        'size': 10,
        'page': ctx.state.currentPage + 1,
        'type': 'BOOK',
        'bid': state.oid,
      },
      onSuccess: (data) {
        state.hasNetworkError = false;
        state.currentPage++;
        state.commentsData.rows.addAll(data.rows);
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: state.commentsData.rows.length,
            totalCount: data.total);
        ctx.dispatch(BookDetailActionCreator.update());
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

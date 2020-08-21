import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/recommend_book_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/page_util.dart';

import 'action.dart';
import 'state.dart';

Effect<AllBookState> buildEffect() {
  return combineEffects(<Object, Effect<AllBookState>>{
    Lifecycle.initState: _init,
    AllBookAction.loadMore: _loadMore
  });
}

void _init(Action action, Context<AllBookState> ctx) {
  ctx.state.currentPage = 1;
  DioUtil.getInstance().doPost<RecommendBookEntity>(
      url: API.search_book,
      context: ctx.context,
      needDelay: true,
      param: {'page': 1, 'size': 15},
      onSuccess: (data) {
        ctx.state.recommendBookData = data;
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

void _loadMore(Action action, Context<AllBookState> ctx) {
  DioUtil.getInstance().doPost<RecommendBookEntity>(
      url: API.search_book,
      context: ctx.context,
      needDelay: true,
      delayMills: Constants.delayLoadMore,
      param: {'page': ctx.state.currentPage + 1, 'size': 15},
      onSuccess: (data) {
        ctx.state.currentPage++;
        ctx.state.recommendBookData.rows.addAll(data.rows);
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: ctx.state.recommendBookData.rows.length,
            totalCount: data.total);
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

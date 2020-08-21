import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/exact_level_class_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/page_util.dart';

import 'action.dart';
import 'state.dart';

Effect<AllRecommendClassState> buildEffect() {
  return combineEffects(<Object, Effect<AllRecommendClassState>>{
    Lifecycle.initState: _init,
    AllRecommendClassAction.loadMore: _loadMore,
  });
}

void _init(Action action, Context<AllRecommendClassState> ctx) {
  ctx.state.currentPage = 1;
  DioUtil.getInstance().doPost<ExactLevelClassEntity>(
      url: API.search_class_with_level,
      context: ctx.context,
      needDelay: true,
      param: {
        'level': ctx.state.level,
        'page': ctx.state.currentPage,
        'size': 15
      },
      onSuccess: (data) {
        ctx.state.classEntity = data;
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

void _loadMore(Action action, Context<AllRecommendClassState> ctx) {
  DioUtil.getInstance().doPost<ExactLevelClassEntity>(
      url: API.search_class_with_level,
      context: ctx.context,
      needDelay: true,
      delayMills: Constants.delayLoadMore,
      param: {
        'level': ctx.state.level,
        'page': ctx.state.currentPage + 1,
        'size': 15
      },
      onSuccess: (data) {
        ctx.state.currentPage++;
        ctx.state.classEntity.rows.addAll(data.rows);
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: ctx.state.classEntity.rows.length,
            totalCount: data.total);
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

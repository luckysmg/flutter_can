import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/home_class_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/tip_util.dart';
import 'action.dart';
import 'state.dart';

Effect<AllClassicalClassState> buildEffect() {
  return combineEffects(<Object, Effect<AllClassicalClassState>>{
    Lifecycle.initState: _init,
    AllClassicalClassAction.init: _init,
    AllClassicalClassAction.loadMore: _loadMore,
  });
}

void _init(Action action, Context<AllClassicalClassState> ctx) {
  ctx.state.currentPage = 1;
  DioUtil.getInstance().doPost<HomeClassEntity>(
      url: API.home_class,
      context: ctx.context,
      needDelay: true,
      delayMills: 200,
      param: {'page': ctx.state.currentPage, 'size': 15, 'type': 'RECOMMEND'},
      onSuccess: (data) {
        ctx.state.hasNetworkError = false;
        ctx.state.freeClassData = data;
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

void _loadMore(Action action, Context<AllClassicalClassState> ctx) {
  DioUtil.getInstance().doPost<HomeClassEntity>(
      url: API.home_class,
      context: ctx.context,
      needDelay: true,
      delayMills: 300,
      param: {
        'page': ctx.state.currentPage + 1,
        'size': 15,
        'type': 'RECOMMEND'
      },
      onSuccess: (data) {
        ctx.state.currentPage++;
        ctx.state.hasNetworkError = false;
        ctx.state.freeClassData.rows.addAll(data.rows);
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: ctx.state.freeClassData.rows.length,
            totalCount: data.total);
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

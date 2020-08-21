import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/galaxy_class_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/tip_util.dart';
import 'action.dart';
import 'state.dart';

Effect<AllGalaxyState> buildEffect() {
  return combineEffects(<Object, Effect<AllGalaxyState>>{
    Lifecycle.initState: _init,
    AllGalaxyAction.init: _init,
    AllGalaxyAction.loadMore: _loadMore,
  });
}

void _init(Action action, Context<AllGalaxyState> ctx) {
  var state = ctx.state;
  state.currentPage = 1;
  DioUtil.getInstance().doPost<GalaxyClassEntity>(
      url: API.discover_category,
      context: ctx.context,
      needDelay: true,
      param: {
        'page': 1,
        'size': 15,
      },
      onSuccess: (data) {
        state.galaxyCategoryData = data;
        PageUtil.updateAfterInitOrRefresh(
            controller: state.refreshController,
            responseDataCount: data.rows.length,
            totalCount: data.total);
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });
}

void _loadMore(Action action, Context<AllGalaxyState> ctx) {
  var state = ctx.state;
  DioUtil.getInstance().doPost<GalaxyClassEntity>(
      url: API.discover_category,
      context: ctx.context,
      needDelay: true,
      delayMills: Constants.delayLoadMore,
      param: {
        'page': state.currentPage + 1,
        'size': 15,
      },
      onSuccess: (data) {
        state.galaxyCategoryData.rows.addAll(data.rows);
        PageUtil.updateAfterLoadMore(
            controller: state.refreshController,
            mergedDataCount: state.galaxyCategoryData.rows.length,
            totalCount: data.total);
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: state.refreshController);
      });
}

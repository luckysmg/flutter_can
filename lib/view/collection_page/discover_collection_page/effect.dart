import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/collection_discover_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';

import 'action.dart';
import 'state.dart';

Effect<DiscoverCollectionState> buildEffect() {
  return combineEffects(<Object, Effect<DiscoverCollectionState>>{
    Lifecycle.initState: _init,
    DiscoverCollectionAction.init: _init,
    DiscoverCollectionAction.loadMore: _loadMore,
  });
}

void _init(Action action, Context<DiscoverCollectionState> ctx) async {
  ctx.state.currentPage = 1;
  DioUtil.getInstance().doPost<CollectionDiscoverEntity>(
      url: API.collection_discover,
      context: ctx.context,
      needDelay: true,
      param: {"page": ctx.state.currentPage, 'size': 15},
      onSuccess: (data) async {
        ctx.state.hasNetworkError = false;
        ctx.state.data = data;
        ctx.dispatch(DiscoverCollectionActionCreator.update());
        PageUtil.updateAfterInitOrRefresh(
            controller: ctx.state.refreshController,
            responseDataCount: data.rows.length,
            totalCount: data.total);
      },
      onFailure: (e) {
        if (e.networkError) {
          ctx.state.hasNetworkError = true;
        }
        ctx.dispatch(DiscoverCollectionActionCreator.update());
        ToastUtil.show(e.msg);
        ctx.state.refreshController.refreshFailed();
      });
}

void _loadMore(Action action, Context<DiscoverCollectionState> ctx) async {
  DioUtil.getInstance().doPost<CollectionDiscoverEntity>(
      url: API.collection_discover,
      context: ctx.context,
      needDelay: true,
      delayMills: Constants.delayLoadMore,
      param: {"page": ctx.state.currentPage + 1, 'size': 15},
      onSuccess: (data) async {
        ctx.state.hasNetworkError = false;
        ctx.state.currentPage++;
        ctx.state.data.rows.addAll(data.rows);
        PageUtil.updateAfterLoadMore(
          controller: ctx.state.refreshController,
          mergedDataCount: ctx.state.data.rows.length,
          totalCount: data.total,
        );
        ctx.dispatch(DiscoverCollectionActionCreator.update());
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
        ctx.state.refreshController.loadFailed();
      });
}

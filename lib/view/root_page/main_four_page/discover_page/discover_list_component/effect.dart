import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/discover_list_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/user_profile_util.dart';

import 'action.dart';
import 'state.dart';

Effect<DiscoverListState> buildEffect() {
  return combineEffects(<Object, Effect<DiscoverListState>>{
    DiscoverListAction.reload: _reload,
    DiscoverListAction.loadMore: _loadMore,
  });
}

void _reload(Action action, Context<DiscoverListState> ctx) {
  DioUtil.getInstance().doPost<DiscoverListEntity>(
      url: API.discover_list,
      context: ctx.context,
      param: {
        'categoryOid': UserProfileUtil.getUserDetailInfo().galaxyCode,
        'page': 1,
        'size': 10,
      },
      onSuccess: (data) async {
        PageUtil.updateAfterInitOrRefresh(
            controller: ctx.state.refreshController,
            responseDataCount: data.rows.length,
            totalCount: data.total);
        ctx.dispatch(DiscoverListActionCreator.updateReload({'newData': data}));
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });
}

void _loadMore(Action action, Context<DiscoverListState> ctx) {
  DioUtil.getInstance().doPost<DiscoverListEntity>(
      url: API.discover_list,
      context: ctx.context,
      needDelay: true,
      delayMills: Constants.delayLoadMore,
      param: {
        'categoryOid': UserProfileUtil.getUserDetailInfo().galaxyCode,
        'page': ctx.state.currentPage + 1,
        'size': 10,
      },
      onSuccess: (data) async {
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount:
                ctx.state.discoverListData.rows.length + data.rows.length,
            totalCount: data.total);
        ctx.dispatch(DiscoverListActionCreator.updateLoadMore(
            {'listData': data, 'currentPage': ctx.state.currentPage}));
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

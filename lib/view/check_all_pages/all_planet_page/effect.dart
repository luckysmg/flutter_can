import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/check_planet_in_galaxy_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/user_profile_util.dart';

import 'action.dart';
import 'state.dart';

Effect<AllPlanetState> buildEffect() {
  return combineEffects(<Object, Effect<AllPlanetState>>{
    Lifecycle.initState: _init,
    AllPlanetAction.loadMore: _loadMore,
  });
}

void _init(Action action, Context<AllPlanetState> ctx) {
  DioUtil.getInstance().doPost<CheckPlanetInGalaxyEntity>(
      url: API.check_planet_with_galaxy_oid,
      context: ctx.context,
      needDelay: true,
      param: {
        'title': "",
        'page': ctx.state.currentPage,
        'size': 15,
        'galaxyOid': UserProfileUtil.getUserDetailInfo().galaxyCode,
      },
      onSuccess: (data) {
        ctx.state.planetInGalaxyEntity = data;
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

void _loadMore(Action action, Context<AllPlanetState> ctx) {
  DioUtil.getInstance().doPost<CheckPlanetInGalaxyEntity>(
      url: API.check_planet_with_galaxy_oid,
      context: ctx.context,
      param: {
        'title': "",
        'page': ctx.state.currentPage + 1,
        'size': 15,
        'galaxyOid': UserProfileUtil.getUserDetailInfo().galaxyCode,
      },
      onSuccess: (data) {
        ctx.state.currentPage++;
        ctx.state.planetInGalaxyEntity.rows.addAll(data.rows);
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: ctx.state.planetInGalaxyEntity.rows.length,
            totalCount: data.total);
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });
}

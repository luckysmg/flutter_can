import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/planet_dynamic_list_entity.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/toast_util.dart';

import 'action.dart';
import 'state.dart';

Effect<PlanetAllDynamicInfoState> buildEffect() {
  return combineEffects(<Object, Effect<PlanetAllDynamicInfoState>>{
    Lifecycle.initState: _init,
    PlanetAllDynamicInfoAction.reload: _init,
    PlanetAllDynamicInfoAction.loadMore: _loadMore,
    PlanetAllDynamicInfoAction.deleteEssay: _deleteEssay,
  });
}

void _init(Action action, Context<PlanetAllDynamicInfoState> ctx) {
  ctx.state.currentPage = 1;
  DioUtil.getInstance().doPost<PlanetDynamicListEntity>(
      url: API.essay_list,
      context: ctx.context,
      needDelay: true,
      param: {
        'communityOid': ctx.state.oid,
        'page': ctx.state.currentPage,
        "size": 10
      },
      onSuccess: (data) {
        ctx.state.listEntity = data;
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

void _loadMore(Action action, Context<PlanetAllDynamicInfoState> ctx) {
  DioUtil.getInstance().doPost<PlanetDynamicListEntity>(
      url: API.essay_list,
      context: ctx.context,
      param: {
        'communityOid': ctx.state.oid,
        'page': ctx.state.currentPage + 1,
        "size": 10
      },
      onSuccess: (data) {
        ctx.state.currentPage++;
        ctx.state.listEntity.rows.addAll(data.rows);
        ctx.forceUpdate();
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: ctx.state.listEntity.rows.length,
            totalCount: data.total);
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

void _deleteEssay(Action action, Context<PlanetAllDynamicInfoState> ctx) {
  int index = action.payload;
  var itemOid = ctx.state.listEntity.rows[index].oid;
  DioUtil.getInstance().doPost<SimpleEntity>(
      url: '${API.delete_essay}/$itemOid',
      context: ctx.context,
      param: {'oid': itemOid},
      onSuccess: (data) {
        ctx.state.listEntity.rows.removeAt(index);
        ctx.forceUpdate();
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

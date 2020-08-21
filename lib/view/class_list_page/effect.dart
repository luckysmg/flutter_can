import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/home_class_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/tip_util.dart';
import 'action.dart';
import 'state.dart';

Effect<ClassListState> buildEffect() {
  return combineEffects(<Object, Effect<ClassListState>>{
    Lifecycle.initState: _init,
    ClassListAction.init: _init,
    ClassListAction.loadMore: _loadMore
  });
}

void _init(Action action, Context<ClassListState> ctx) {
  ctx.state.currentPage = 1;
  DioUtil.getInstance().doPost<HomeClassEntity>(
      url: API.good_class_category_list,
      needDelay: true,
      delayMills: 200,
      context: ctx.context,
      param: {
        'categoryOid': ctx.state.oid,
        'page': ctx.state.currentPage,
        'size': 15
      },
      onSuccess: (data) {
        ctx.state.classData = data;
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

void _loadMore(Action action, Context<ClassListState> ctx) {
  DioUtil.getInstance().doPost<HomeClassEntity>(
      url: API.good_class_category_list,
      context: ctx.context,
      needDelay: true,
      delayMills: 300,
      param: {
        'categoryOid': ctx.state.oid,
        'page': ctx.state.currentPage + 1,
        'size': 15
      },
      onSuccess: (data) {
        ctx.state.currentPage++;
        ctx.state.classData.rows.addAll(data.rows);
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: ctx.state.classData.rows.length,
            totalCount: data.total);
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

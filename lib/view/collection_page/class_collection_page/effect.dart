import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/collection_class_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';

import 'action.dart';
import 'state.dart';

Effect<ClassCollectionState> buildEffect() {
  return combineEffects(<Object, Effect<ClassCollectionState>>{
    ClassCollectionAction.init: _init,
    ClassCollectionAction.loadMore: _loadMore,
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<ClassCollectionState> ctx) {
  ctx.state.currentPage = 1;
  DioUtil.getInstance().doPost<CollectionClassEntity>(
      url: API.collection_class_list,
      context: ctx.context,
      needDelay: true,
      param: {'page': ctx.state.currentPage, 'size': 15},
      onSuccess: (data) {
        ctx.state.hasNetworkError = false;
        ctx.state.data = data;
        PageUtil.updateAfterInitOrRefresh(
            controller: ctx.state.refreshController,
            responseDataCount: data.rows.length,
            totalCount: data.total);
        ctx.dispatch(ClassCollectionActionCreator.update());
      },
      onFailure: (e) {
        if (e.networkError) {
          ctx.state.hasNetworkError = true;
          ctx.dispatch(ClassCollectionActionCreator.update());
        }
        ToastUtil.show(e.msg);
      });
}

void _loadMore(Action action, Context<ClassCollectionState> ctx) {
  DioUtil.getInstance().doPost<CollectionClassEntity>(
      url: API.collection_class_list,
      context: ctx.context,
      needDelay: true,
      delayMills: Constants.delayLoadMore,
      param: {
        'page': ctx.state.currentPage + 1,
        'size': 15,
      },
      onSuccess: (data) {
        ctx.state.currentPage++;
        ctx.state.hasNetworkError = false;
        ctx.state.data.rows.addAll(data.rows);
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: ctx.state.data.rows.length,
            totalCount: data.total);
        ctx.dispatch(ClassCollectionActionCreator.update());
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

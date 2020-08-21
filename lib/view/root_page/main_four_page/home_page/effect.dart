import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:neng/entity/home_banner_entity.dart';
import 'package:neng/entity/home_class_entity.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/view/root_page/main_four_page/home_page/banner_component/action.dart';

import 'action.dart';
import 'state.dart';

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    Lifecycle.initState: _init,
    HomeAction.loadMore: _loadMore,
    HomeAction.scrollToTop: _scrollToTop,
  });
}

void _loadMore(Action action, Context<HomeState> ctx) {
  DioUtil.getInstance().doPost<HomeClassEntity>(
      url: API.home_class,
      context: ctx.context,
      needDelay: true,
      param: {'page': ctx.state.currentPage + 1, 'size': 10, 'type': 'ALL'},
      onSuccess: (data) {
        ctx.state.currentPage++;
        ctx.state.newClassData.rows.addAll(data.rows);
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: ctx.state.newClassData.rows.length,
            totalCount: data.total);
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

void _init(Action action, Context<HomeState> ctx) async {
  ///用户状态切换事件监听
  GlobalStore.getEventBus().on<UserInfoChangeEvent>().listen((_) {
    ctx.dispatch(HomeActionCreator.update());
  });

  ctx.state.currentPage = 1;

  ///请求banner 接口
  DioUtil.getInstance().doPost<HomeBannerEntity>(
      url: API.home_banner,
      context: ctx.context,
      onSuccess: (data) {
        ctx.dispatch(BannerActionCreator.init(data));
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });

  ///请求免费课程
  var getFreeClassData = DioUtil.getInstance().doPost<HomeClassEntity>(
    url: API.home_class,
    context: ctx.context,
    param: {'page': 1, 'size': 5, 'type': 'FREE'},
    onSuccess: (data) {
      ctx.state.freeClassData = data;
    },
  );

  ///请求精品课程
  var getGoodClassData = DioUtil.getInstance().doPost<HomeClassEntity>(
    url: API.home_class,
    context: ctx.context,
    param: {'page': 1, 'size': 5, 'type': 'RECOMMEND'},
    onSuccess: (data) {
      ctx.state.goodClassData = data;
    },
  );

  ///请求上新课程
  var getNewClassData = DioUtil.getInstance().doPost<HomeClassEntity>(
    url: API.home_class,
    context: ctx.context,
    param: {'page': 1, 'size': 10, 'type': 'ALL'},
    onSuccess: (data) {
      ctx.state.newClassData = data;
      PageUtil.updateAfterInitOrRefresh(
          controller: ctx.state.refreshController,
          responseDataCount: data.rows.length,
          totalCount: data.total);
    },
  );

  await Future.wait([
    getFreeClassData,
    getGoodClassData,
    getNewClassData,
  ]);
  ctx.forceUpdate();
}

void _scrollToTop(Action action, Context<HomeState> ctx) {
  ctx.state.scrollController.animateTo(0,
      duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
}

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:neng/entity/galaxy_class_entity.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/entity/user_profile_entity.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/util/user_profile_util.dart';

import 'action.dart';
import 'state.dart';

Effect<AllGalaxySelectState> buildEffect() {
  return combineEffects(<Object, Effect<AllGalaxySelectState>>{
    Lifecycle.initState: _init,
    AllGalaxySelectAction.init: _init,
    AllGalaxySelectAction.loadMore: _loadMore,
    AllGalaxySelectAction.settle: _settle,
  });
}

void _init(Action action, Context<AllGalaxySelectState> ctx) {
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

void _loadMore(Action action, Context<AllGalaxySelectState> ctx) {
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

void _settle(Action action, Context<AllGalaxySelectState> ctx) {
  String oid = action.payload['oid'];
  String name = action.payload['name'];
  DioUtil.getInstance().doPost<SimpleEntity>(
      url: API.save_galaxy,
      context: ctx.context,
      param: {'galaxyCode': oid, 'galaxyName': name},
      onSuccess: (data) async {
        UserProfileEntity userDetailInfo = UserProfileUtil.getUserDetailInfo();
        userDetailInfo.galaxyCode = oid;
        userDetailInfo.galaxyName = name;
        await UserProfileUtil.setUserDetailInfo(userDetailInfo);
        GlobalStore.getEventBus().fire(UserInfoChangeEvent());
        Navigator.pop(ctx.context, true);
        Navigator.pop(ctx.context);
        //ToastUtil.show('定居成功.');
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

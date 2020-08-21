import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:neng/entity/discover_list_entity.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/entity/user_profile_entity.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/util/user_profile_util.dart';

import 'action.dart';
import 'state.dart';

Effect<GalaxyDetailState> buildEffect() {
  return combineEffects(<Object, Effect<GalaxyDetailState>>{
    Lifecycle.initState: _init,
    GalaxyDetailAction.settle: _settle,
  });
}

void _init(Action action, Context<GalaxyDetailState> ctx) async {
  ctx.state.currentPage = 1;

  ///如果用户已经登录，并且已经定居星球,那么请求文章数据

  await DioUtil.getInstance().doPost<DiscoverListEntity>(
      url: API.discover_list,
      context: ctx.context,
      needDelay: true,
      param: {
        'categoryOid': ctx.state.oid,
        'page': ctx.state.currentPage,
        'size': 10,
      },
      onSuccess: (data) {
        ctx.state.discoverListData = data;
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });
  ctx.forceUpdate();
}

void _settle(Action action, Context<GalaxyDetailState> ctx) {
  if (!UserProfileUtil.isUserLogin()) {
    UserProfileUtil.pushLoginPage(ctx.context);
    return;
  }
  DioUtil.getInstance().doPost<SimpleEntity>(
      url: API.save_galaxy,
      context: ctx.context,
      param: {'galaxyCode': ctx.state.oid, 'galaxyName': ctx.state.title},
      onSuccess: (data) async {
        UserProfileEntity userDetailInfo = UserProfileUtil.getUserDetailInfo();
        userDetailInfo.galaxyCode = ctx.state.oid;
        userDetailInfo.galaxyName = ctx.state.title;
        await UserProfileUtil.setUserDetailInfo(userDetailInfo);
        GlobalStore.getEventBus().fire(UserInfoChangeEvent());
        Navigator.pop(ctx.context, true);
        //ToastUtil.show('定居成功.');
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

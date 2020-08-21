import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' as widget;
import 'package:neng/entity/home_class_list_entity.dart';
import 'package:neng/entity/recommend_book_entity.dart';
import 'package:neng/entity/recommend_certification_entity.dart';
import 'package:neng/entity/recommend_profession_entity.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/image_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/util/user_profile_util.dart';

import 'action.dart';
import 'state.dart';

Effect<ProfessionState> buildEffect() {
  return combineEffects(<Object, Effect<ProfessionState>>{
    Lifecycle.initState: _init,
    ProfessionAction.switchExpanded: _switchExpanded,
  });
}

void _switchExpanded(Action action, Context<ProfessionState> ctx) {
  bool status = !ctx.state.expanded;
  ctx.state.expanded = status;
  ctx.forceUpdate();
}

void _init(Action action, Context<ProfessionState> ctx) {
  ///注册用户事件监听
  GlobalStore.getEventBus().on<UserInfoChangeEvent>().listen((data) {
    if (!data.isLogin) {
      ctx.state.isUserLogin = false;
      ctx.forceUpdate();
      return;
    }
    _requestData(ctx);
  });
  _requestData(ctx);
}

void _requestData(Context<ProfessionState> ctx) async {
  ///如果用户登陆了并且已经选择了职业才进行请求，不然会弹出登陆界面
  if (UserProfileUtil.isUserLogin() &&
      UserProfileUtil.getUserDetailInfo().professionName != null) {
    var getClassDetail = DioUtil.getInstance().doPost<HomeClassListEntity>(
        url: API.home_class_list,
        context: ctx.context,
        needDelay: true,
        delayMills: 400,
        param: {'size': 4},
        onSuccess: (data) {
          ctx.state.isUserLogin = true;
          ctx.state.homeClassListData = data;
        },
        onFailure: (e) {
          if (e.networkError) {
            ctx.state.hasNetworkError = true;
            ctx.forceUpdate();
          }

          ///如果这里触发了请求但是出现如下情况，那么是token过期导致的
          if (e.code == 10004 || e.code == 10000 || e.code == 10003) {
            ctx.state.isUserLogin = false;
            ctx.forceUpdate();
          }
          ToastUtil.show(e.msg);
        });

    var getRecommendProfessionDetail =
        DioUtil.getInstance().doPost<RecommendProfessionEntity>(
            url: API.search_recommend_profession,
            context: ctx.context,
            onSuccess: (data) {
              ctx.state.recommendProfessionData = data;
            },
            onFailure: (e) {
              if (e.networkError) {
                ctx.state.hasNetworkError = true;
                ctx.forceUpdate();
              }
              ToastUtil.show(e.msg);
            });

    var getBookDetail = DioUtil.getInstance().doPost<RecommendBookEntity>(
        url: API.search_book,
        context: ctx.context,
        param: {'page': 1, 'size': 6},
        onSuccess: (data) {
          ctx.state.recommendBookData = data;
        },
        onFailure: (e) {
          if (e.networkError) {
            ctx.state.hasNetworkError = true;
            ctx.forceUpdate();
          }
          ToastUtil.show(e.msg);
        });

    var getCertificationData =
        DioUtil.getInstance().doPost<RecommendCertificationEntity>(
            url: API.search_certification,
            context: ctx.context,
            param: {'page': 1, 'size': 8},
            onSuccess: (data) {
              ctx.state.recommendCertificationData = data;
            },
            onFailure: (e) {
              if (e.networkError) {
                ctx.state.hasNetworkError = true;
                ctx.forceUpdate();
              }
              ToastUtil.show(e.msg);
            });

    await Future.wait([
      getClassDetail,
      getRecommendProfessionDetail,
      getBookDetail,
      getCertificationData
    ]);
    ctx.state.refreshController.refreshCompleted();
  }
  ctx.forceUpdate();
}

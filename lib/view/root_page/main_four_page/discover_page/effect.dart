import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/check_planet_in_galaxy_entity.dart';
import 'package:neng/entity/discover_list_entity.dart';
import 'package:neng/entity/galaxy_class_entity.dart';
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

Effect<DiscoverState> buildEffect() {
  return combineEffects(<Object, Effect<DiscoverState>>{
    DiscoverAction.reload: _reload,
    Lifecycle.initState: _init,
  });
}

void _reload(Action action, Context<DiscoverState> ctx) {
  DioUtil.getInstance().doPost<CheckPlanetInGalaxyEntity>(
      url: API.check_planet_with_galaxy_oid,
      context: ctx.context,
      param: {
        'title': "",
        "page": 1,
        'size': 5,
        'galaxyOid': UserProfileUtil.getUserDetailInfo().galaxyCode,
      },
      onSuccess: (data) {
        ctx.state.planetInGalaxyListData = data;
        ctx.forceUpdate();
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

void _init(Action action, Context<DiscoverState> ctx) async {
  ///注册事件监听，在切换星球的时候更新页面并且在用户已经登录，并且选择星球情况下请求文章数据
  if (!ctx.state.hasEventBind) {
    GlobalStore.getEventBus().on<UserInfoChangeEvent>().listen((data) async {
      await _getListData(ctx);
      ctx.dispatch(DiscoverActionCreator.reload());
    });
    ctx.state.hasEventBind = true;
  }

  var getPlanetList = DioUtil.getInstance().doPost<CheckPlanetInGalaxyEntity>(
      url: API.check_planet_with_galaxy_oid,
      context: ctx.context,
      param: {
        'title': "",
        "page": 1,
        'size': 5,
        'galaxyOid': UserProfileUtil.getUserDetailInfo().galaxyCode,
      },
      onSuccess: (data) {
        ctx.state.planetInGalaxyListData = data;
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });

  ///请求星球分类数据集合
  var getCategoryData = DioUtil.getInstance().doPost<GalaxyClassEntity>(
      url: API.discover_category,
      context: ctx.context,
      param: {
        'page': 1,
        'size': 5,
      },
      onSuccess: (data) {
        ctx.state.tabCategoriesData = data;
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });
  await _getListData(ctx);

  ///根据用户定居的星球，来请求对应的文章
  await Future.wait([getCategoryData, _getListData(ctx), getPlanetList]);
  ctx.state.refreshController.refreshCompleted(resetFooterState: true);
  ctx.forceUpdate();
}

Future _getListData(Context<DiscoverState> ctx) async {
  ctx.state.currentPage = 1;
  if (UserProfileUtil.isUserLogin() &&
      UserProfileUtil.getUserDetailInfo().galaxyName != null) {
    ///如果用户已经登录，并且已经定居星球,那么请求文章数据

    await DioUtil.getInstance().doPost<DiscoverListEntity>(
        url: API.discover_list,
        context: ctx.context,
        needDelay: true,
        param: {
          'categoryOid': UserProfileUtil.getUserDetailInfo().galaxyCode,
          'page': ctx.state.currentPage,
          'size': 10,
        },
        onSuccess: (data) {
          ctx.state.discoverListData = data;
        },
        onFailure: (e) {
          PageUtil.initFail(ctx, e);
        });
  }
}

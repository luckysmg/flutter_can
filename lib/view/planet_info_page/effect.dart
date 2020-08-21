import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/planet_detail_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';

import 'action.dart';
import 'state.dart';

Effect<PlanetInfoState> buildEffect() {
  return combineEffects(<Object, Effect<PlanetInfoState>>{
    Lifecycle.initState: _init,
    PlanetInfoAction.joinPlanet: _joinPlanet,
    PlanetInfoAction.reload: _init,
  });
}

void _init(Action action, Context<PlanetInfoState> ctx) {
  DioUtil.getInstance().doPost<PlanetDetailEntity>(
      url: '${API.planet_detail}/${ctx.state.oid}',
      context: ctx.context,
      needDelay: true,
      onSuccess: (data) {
        ctx.state.planetDetailEntity = data;
        ctx.forceUpdate();
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

void _joinPlanet(Action action, Context<PlanetInfoState> ctx) {
  DioUtil.getInstance().doPost(
      url: API.join_planet,
      context: ctx.context,
      param: {'oid': ctx.state.oid},
      onSuccess: (data) {
        ToastUtil.show('加入成功');
        ctx.state.planetDetailEntity.data.joinStatus = "YES";
        ctx.forceUpdate();
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

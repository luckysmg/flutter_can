import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/planet_detail_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:neng/util/user_profile_util.dart';

class PlanetDetailState with BaseState implements Cloneable<PlanetDetailState> {
  String oid;

  PlanetDetailEntity planetDetailEntity;

  @override
  PlanetDetailState clone() {
    return PlanetDetailState()
      ..oid = oid
      ..hasNetworkError = hasNetworkError
      ..planetDetailEntity = planetDetailEntity;
  }
}

PlanetDetailState initState(Map<String, dynamic> args) {
  return PlanetDetailState()..oid = args['oid'];
}

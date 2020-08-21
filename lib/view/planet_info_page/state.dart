import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/planet_detail_entity.dart';
import 'package:neng/redux/base_state.dart';

class PlanetInfoState with BaseState implements Cloneable<PlanetInfoState> {
  String oid;

  ///星主名字
  String galaxyOwnerName;

  PlanetDetailEntity planetDetailEntity;

  @override
  PlanetInfoState clone() {
    return PlanetInfoState()
      ..planetDetailEntity = planetDetailEntity
      ..hasNetworkError = hasNetworkError
      ..galaxyOwnerName = galaxyOwnerName
      ..oid = oid;
  }
}

PlanetInfoState initState(Map<String, dynamic> args) {
  return PlanetInfoState()
    ..oid = args['oid']
    ..galaxyOwnerName = args['galaxyOwnerName'];
}

import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/check_planet_in_galaxy_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllPlanetState with BaseState implements Cloneable<AllPlanetState> {
  int currentPage;
  RefreshController refreshController;
  CheckPlanetInGalaxyEntity planetInGalaxyEntity;

  @override
  AllPlanetState clone() {
    return AllPlanetState()
      ..hasNetworkError = hasNetworkError
      ..currentPage = currentPage
      ..refreshController = refreshController
      ..planetInGalaxyEntity = planetInGalaxyEntity;
  }
}

AllPlanetState initState(Map<String, dynamic> args) {
  return AllPlanetState()
    ..currentPage = 1
    ..refreshController = RefreshController();
}

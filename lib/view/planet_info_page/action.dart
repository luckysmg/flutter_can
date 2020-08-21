import 'package:fish_redux/fish_redux.dart';

enum PlanetInfoAction { joinPlanet, reload }

class PlanetInfoActionCreator {
  static Action joinPlanet() {
    return const Action(PlanetInfoAction.joinPlanet);
  }

  static Action reload() {
    return const Action(PlanetInfoAction.reload);
  }
}

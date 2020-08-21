import 'package:fish_redux/fish_redux.dart';

enum BuildPlanetAction { addPlanet, selectImg }

class BuildPlanetActionCreator {
  static Action addPlanet() {
    return const Action(BuildPlanetAction.addPlanet);
  }

  static Action selectImg(bool useCamera) {
    return Action(BuildPlanetAction.selectImg, payload: useCamera);
  }
}

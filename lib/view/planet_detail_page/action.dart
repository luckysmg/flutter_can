import 'package:fish_redux/fish_redux.dart';

enum PlanetDetailAction { action, selectImg }

class PlanetDetailActionCreator {
  static Action onAction() {
    return const Action(PlanetDetailAction.action);
  }

  static Action selectImg(bool useCamera) {
    return Action(PlanetDetailAction.selectImg, payload: useCamera);
  }
}

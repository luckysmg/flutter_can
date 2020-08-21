import 'package:fish_redux/fish_redux.dart';

enum AllPlanetAction { action, loadMore }

class AllPlanetActionCreator {
  static Action onAction() {
    return const Action(AllPlanetAction.action);
  }

  static Action loadMore() {
    return Action(AllPlanetAction.loadMore);
  }
}

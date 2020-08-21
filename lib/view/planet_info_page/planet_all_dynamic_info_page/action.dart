import 'package:fish_redux/fish_redux.dart';

enum PlanetAllDynamicInfoAction { reload, loadMore, deleteEssay }

class PlanetAllDynamicInfoActionCreator {
  static Action reload() {
    return const Action(PlanetAllDynamicInfoAction.reload);
  }

  static Action loadMore() {
    return const Action(PlanetAllDynamicInfoAction.loadMore);
  }

  static Action deleteEssay(int index) {
    return Action(PlanetAllDynamicInfoAction.deleteEssay, payload: index);
  }
}

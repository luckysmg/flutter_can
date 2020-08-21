import 'package:fish_redux/fish_redux.dart';

enum AllGalaxyAction {
  action,
  init,
  loadMore,
}

class AllGalaxyActionCreator {
  static Action onAction() {
    return const Action(AllGalaxyAction.action);
  }

  static Action init() {
    return Action(AllGalaxyAction.init);
  }

  static Action loadMore() {
    return Action(AllGalaxyAction.loadMore);
  }
}

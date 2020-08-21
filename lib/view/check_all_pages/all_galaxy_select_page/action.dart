import 'package:fish_redux/fish_redux.dart';

enum AllGalaxySelectAction { action, init, loadMore, settle }

class AllGalaxySelectActionCreator {
  static Action onAction() {
    return const Action(AllGalaxySelectAction.action);
  }

  static Action init() {
    return Action(AllGalaxySelectAction.init);
  }

  static Action loadMore() {
    return Action(AllGalaxySelectAction.loadMore);
  }

  static Action settle(String oid, String name) {
    return Action(AllGalaxySelectAction.settle,
        payload: {'oid': oid, 'name': name});
  }
}

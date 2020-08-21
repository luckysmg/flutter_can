import 'package:fish_redux/fish_redux.dart';

enum AllClassicalClassAction {
  action,
  init,
  loadMore,
}

class AllClassicalClassActionCreator {
  static Action onAction() {
    return const Action(AllClassicalClassAction.action);
  }

  static Action init() {
    return Action(AllClassicalClassAction.init);
  }

  static Action loadMore() {
    return Action(AllClassicalClassAction.loadMore);
  }
}

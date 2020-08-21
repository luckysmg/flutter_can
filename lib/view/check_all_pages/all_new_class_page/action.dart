import 'package:fish_redux/fish_redux.dart';

enum AllNewClassAction {
  action,
  init,
  loadMore,
}

class AllNewClassActionCreator {
  static Action onAction() {
    return const Action(AllNewClassAction.action);
  }

  static Action init() {
    return Action(AllNewClassAction.init);
  }

  static Action loadMore() {
    return Action(AllNewClassAction.loadMore);
  }
}

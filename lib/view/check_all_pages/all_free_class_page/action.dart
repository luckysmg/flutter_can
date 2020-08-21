import 'package:fish_redux/fish_redux.dart';

enum AllFreeClassAction {
  action,
  init,
  loadMore,
}

class AllFreeClassActionCreator {
  static Action onAction() {
    return const Action(AllFreeClassAction.action);
  }

  static Action init() {
    return Action(AllFreeClassAction.init);
  }

  static Action loadMore() {
    return Action(AllFreeClassAction.loadMore);
  }
}

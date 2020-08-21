import 'package:fish_redux/fish_redux.dart';

enum ClassListAction {
  action,
  init,
  loadMore,
}

class ClassListActionCreator {
  static Action onAction() {
    return const Action(ClassListAction.action);
  }

  static Action init() {
    return Action(ClassListAction.init);
  }

  static Action loadMore() {
    return Action(ClassListAction.loadMore);
  }
}

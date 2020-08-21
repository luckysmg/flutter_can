import 'package:fish_redux/fish_redux.dart';

enum ClassCollectionAction { action, init, update, loadMore }

class ClassCollectionActionCreator {
  static Action onAction() {
    return const Action(ClassCollectionAction.action);
  }

  static Action init() {
    return Action(ClassCollectionAction.init);
  }

  static Action update() {
    return Action(ClassCollectionAction.update);
  }

  static Action loadMore() {
    return Action(ClassCollectionAction.loadMore);
  }
}

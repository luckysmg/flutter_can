import 'package:fish_redux/fish_redux.dart';

enum RootAction {
  action,
}

class RootActionCreator {
  static Action onAction() {
    return const Action(RootAction.action);
  }
}

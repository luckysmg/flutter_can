import 'package:fish_redux/fish_redux.dart';

enum ClassAction { action, init }

class ClassActionCreator {
  static Action onAction() {
    return const Action(ClassAction.action);
  }

  static Action init() {
    return const Action(ClassAction.init);
  }
}

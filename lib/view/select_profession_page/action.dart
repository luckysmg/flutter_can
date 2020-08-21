import 'package:fish_redux/fish_redux.dart';

enum SelectProfessionAction { action, init, update }

class SelectProfessionActionCreator {
  static Action onAction() {
    return const Action(SelectProfessionAction.action);
  }

  static Action init() {
    return Action(SelectProfessionAction.init);
  }

  static Action update() {
    return Action(SelectProfessionAction.update);
  }
}

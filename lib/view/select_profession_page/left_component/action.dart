import 'package:fish_redux/fish_redux.dart';

enum LeftAction { switchIndex, update }

class LeftActionCreator {
  static Action switchIndex(int index) {
    return Action(LeftAction.switchIndex, payload: index);
  }

  static Action update() {
    return Action(LeftAction.update);
  }
}

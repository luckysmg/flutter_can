import 'package:fish_redux/fish_redux.dart';

enum ClassLeftAction { switchIndex }

class ClassLeftActionCreator {
  static Action switchIndex(int index) {
    return Action(ClassLeftAction.switchIndex, payload: index);
  }
}

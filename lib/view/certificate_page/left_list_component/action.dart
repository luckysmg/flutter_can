import 'package:fish_redux/fish_redux.dart';

enum LeftListAction { switchIndex }

class LeftListActionCreator {
  static Action switchIndex(int index) {
    return Action(LeftListAction.switchIndex, payload: index);
  }
}

import 'package:fish_redux/fish_redux.dart';

enum RightListAction { switchIndex }

class RightListActionCreator {
  static Action switchIndex() {
    return Action(
      RightListAction.switchIndex,
    );
  }
}

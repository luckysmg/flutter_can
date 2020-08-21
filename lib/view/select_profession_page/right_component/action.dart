import 'package:fish_redux/fish_redux.dart';

enum RightAction { switchIndex, selectProfession }

class RightActionCreator {
  static Action switchIndex() {
    return Action(
      RightAction.switchIndex,
    );
  }

  static Action selectProfession(Map map) {
    return Action(RightAction.selectProfession, payload: map);
  }
}

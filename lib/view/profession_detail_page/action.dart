import 'package:fish_redux/fish_redux.dart';

enum ProfessionDetailAction { init, selectProfession, switchExpanded }

class ProfessionDetailActionCreator {
  static Action init() {
    return const Action(ProfessionDetailAction.init);
  }

  static Action selectProfession(Map map) {
    return Action(ProfessionDetailAction.selectProfession, payload: map);
  }

  static Action switchExpanded() {
    return Action(ProfessionDetailAction.switchExpanded);
  }
}

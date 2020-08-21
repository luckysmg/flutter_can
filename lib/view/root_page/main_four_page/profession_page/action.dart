import 'package:fish_redux/fish_redux.dart';

enum ProfessionAction { init, switchExpanded }

class ProfessionActionCreator {
  static Action init() {
    return const Action(ProfessionAction.init);
  }

  static Action switchExpanded() {
    return Action(ProfessionAction.switchExpanded);
  }
}

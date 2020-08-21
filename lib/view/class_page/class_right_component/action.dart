import 'package:fish_redux/fish_redux.dart';

enum ClassRightAction { switchIndex }

class ClassRightActionCreator {
  static Action switchIndex() {
    return const Action(ClassRightAction.switchIndex);
  }
}

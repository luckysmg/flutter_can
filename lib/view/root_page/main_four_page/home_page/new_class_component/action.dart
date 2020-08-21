import 'package:fish_redux/fish_redux.dart';

enum NewClassAction { action }

class NewClassActionCreator {
  static Action onAction() {
    return const Action(NewClassAction.action);
  }
}

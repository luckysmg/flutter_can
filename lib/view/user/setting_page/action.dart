import 'package:fish_redux/fish_redux.dart';

enum SettingAction { action, userLogout }

class SettingActionCreator {
  static Action onAction() {
    return const Action(SettingAction.action);
  }

  static Action userLogout() {
    return const Action(SettingAction.userLogout);
  }
}

import 'package:fish_redux/fish_redux.dart';

enum GalaxyDetailAction { action, settle }

class GalaxyDetailActionCreator {
  static Action onAction() {
    return const Action(GalaxyDetailAction.action);
  }

  static Action settle() {
    return const Action(GalaxyDetailAction.settle);
  }
}

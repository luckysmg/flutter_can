import 'package:fish_redux/fish_redux.dart';

enum DiscoverAction { action, update, reload }

class DiscoverActionCreator {
  static Action onAction() {
    return const Action(DiscoverAction.action);
  }

  static Action update() {
    return Action(DiscoverAction.update);
  }

  static Action reload() {
    return Action(DiscoverAction.reload);
  }
}

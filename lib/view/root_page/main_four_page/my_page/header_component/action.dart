import 'package:fish_redux/fish_redux.dart';

enum HeaderAction { action, prepareJumpPage }

class HeaderActionCreator {
  static Action onAction() {
    return const Action(HeaderAction.action);
  }

  static Action prepareJumpPage() {
    return Action(HeaderAction.prepareJumpPage);
  }
}

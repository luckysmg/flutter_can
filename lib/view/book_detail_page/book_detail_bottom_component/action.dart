import 'package:fish_redux/fish_redux.dart';

enum BookDetailBottomAction {
  action,
  addComment,
  update,
  onCollect,
  collect,
}

class BookDetailBottomActionCreator {
  static Action onAction() {
    return const Action(BookDetailBottomAction.action);
  }

  static Action addComment() {
    return const Action(BookDetailBottomAction.addComment);
  }

  static Action update() {
    return const Action(BookDetailBottomAction.update);
  }

  static Action onCollect() {
    return const Action(BookDetailBottomAction.onCollect);
  }

  static Action collect(Map map) {
    return Action(BookDetailBottomAction.collect, payload: map);
  }
}

import 'package:fish_redux/fish_redux.dart';

enum BookDetailAction {
  action,
  init,
  update,
  loadMore,
}

class BookDetailActionCreator {
  static Action onAction() {
    return const Action(BookDetailAction.action);
  }

  static Action init() {
    return const Action(BookDetailAction.init);
  }

  static Action update() {
    return const Action(BookDetailAction.update);
  }

  static Action loadMore() {
    return const Action(BookDetailAction.loadMore);
  }
}

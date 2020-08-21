import 'package:fish_redux/fish_redux.dart';

enum BookDetailCommentListAction { action, onRefreshComment, refreshComment }

class BookDetailCommentListActionCreator {
  static Action onAction() {
    return const Action(BookDetailCommentListAction.action);
  }

  static Action onRefreshComment() {
    return const Action(BookDetailCommentListAction.onRefreshComment);
  }

  static Action refreshComment(data) {
    return Action(BookDetailCommentListAction.refreshComment, payload: data);
  }
}

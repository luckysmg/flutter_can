import 'package:fish_redux/fish_redux.dart';

enum CommentAction {
  init,
  update,
  loadMore,
}

class CommentActionCreator {
  static Action init() {
    return Action(CommentAction.init);
  }

  static Action update() {
    return Action(CommentAction.update);
  }

  static Action loadMore() {
    return Action(CommentAction.loadMore);
  }
}

import 'package:fish_redux/fish_redux.dart';

enum DetailCommentAction { init, update, loadMore, comment }

class DetailCommentActionCreator {
  static Action init() {
    return const Action(DetailCommentAction.init);
  }

  static Action update() {
    return const Action(DetailCommentAction.update);
  }

  static Action loadMore() {
    return const Action(DetailCommentAction.loadMore);
  }

  static Action comment() {
    return const Action(DetailCommentAction.comment);
  }
}

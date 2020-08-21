import 'package:fish_redux/fish_redux.dart';

enum CommentBoxAction { collect, update, addComment, updateCollect }

class CommentBoxActionCreator {
  static Action collect(bool status) {
    return Action(CommentBoxAction.collect, payload: status);
  }

  static Action update(Map map) {
    return Action(CommentBoxAction.update, payload: map);
  }

  static Action addComment() {
    return Action(
      CommentBoxAction.addComment,
    );
  }

  static Action updateCollect(Map map) {
    return Action(CommentBoxAction.updateCollect, payload: map);
  }
}

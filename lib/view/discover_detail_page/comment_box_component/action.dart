import 'package:fish_redux/fish_redux.dart';

enum CommentBoxAction { onCollect, updateCollect, onLike, updateLike }

class CommentBoxActionCreator {
  static Action onCollect(bool status) {
    return Action(CommentBoxAction.onCollect, payload: status);
  }

  static Action updateCollect(Map map) {
    return Action(CommentBoxAction.updateCollect, payload: map);
  }

  static Action onLike(bool status) {
    return Action(CommentBoxAction.onLike, payload: status);
  }

  static Action updateLick(Map map) {
    return Action(CommentBoxAction.updateLike, payload: map);
  }
}

import 'package:fish_redux/fish_redux.dart';

enum EssayDetailAction {
  action,
  collect,
  like,
  comment,
  reloadCommentList,
  loadMore,
}

class EssayDetailActionCreator {
  static Action onAction() {
    return const Action(EssayDetailAction.action);
  }

  static Action collect() {
    return const Action(EssayDetailAction.collect);
  }

  static Action like() {
    return const Action(EssayDetailAction.like);
  }

  static Action comment() {
    return const Action(EssayDetailAction.comment);
  }

  static Action reloadCommentList() {
    return const Action(EssayDetailAction.reloadCommentList);
  }

  static Action loadMore() {
    return const Action(EssayDetailAction.loadMore);
  }
}

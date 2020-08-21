import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/comment_list_entity.dart';

enum DiscoverDetailAction {
  reload,
  init,
  onAddComment,
  onRefreshCommentList,
  refreshCommentList,
  scrollToComment,
  update,
  loadMore,
}

class DiscoverDetailActionCreator {
  static Action reload() {
    return Action(
      DiscoverDetailAction.reload,
    );
  }

  static Action init(Map data) {
    return Action(DiscoverDetailAction.init, payload: data);
  }

  static Action onAddComment() {
    return Action(DiscoverDetailAction.onAddComment);
  }

  static Action onRefreshCommentList() {
    return Action(DiscoverDetailAction.onRefreshCommentList);
  }

  static Action refreshCommentList(CommentListEntity data) {
    return Action(DiscoverDetailAction.refreshCommentList, payload: data);
  }

  static Action scrollToComment() {
    return Action(DiscoverDetailAction.scrollToComment);
  }

  static Action update() {
    return Action(DiscoverDetailAction.update);
  }

  static Action loadMore() {
    return Action(DiscoverDetailAction.loadMore);
  }
}

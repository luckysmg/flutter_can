import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommentState with BaseState implements Cloneable<CommentState> {
  RefreshController refreshController;
  int currentPage;

  @override
  CommentState clone() {
    return CommentState()
      ..hasNetworkError = hasNetworkError
      ..currentPage = currentPage
      ..refreshController = refreshController;
  }
}

CommentState initState(Map<String, dynamic> args) {
  return CommentState()
    ..currentPage = 1
    ..refreshController = RefreshController();
}

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<BookDetailCommentListState> buildReducer() {
  return asReducer(
    <Object, Reducer<BookDetailCommentListState>>{
      BookDetailCommentListAction.refreshComment: _refreshComment,
    },
  );
}

BookDetailCommentListState _refreshComment(
    BookDetailCommentListState state, Action action) {
  var newData = action.payload;
  final BookDetailCommentListState newState = state.clone();
  newState.commentsData = newData;
  return newState;
}

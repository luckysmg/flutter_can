import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DiscoverDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<DiscoverDetailState>>{
      DiscoverDetailAction.init: _init,
      DiscoverDetailAction.refreshCommentList: _refreshCommentList,
      DiscoverDetailAction.update: _update,
    },
  );
}

DiscoverDetailState _init(DiscoverDetailState state, Action action) {
  final DiscoverDetailState newState = state.clone();
  newState.detailData = action.payload['detailData'];
  newState.commentsData = action.payload['commentsData'];
  return newState;
}

DiscoverDetailState _refreshCommentList(
    DiscoverDetailState state, Action action) {
  final DiscoverDetailState newState = state.clone();
  newState.commentsData = action.payload;
  return newState;
}

DiscoverDetailState _update(DiscoverDetailState state, Action action) {
  final DiscoverDetailState newState = state.clone();
  return newState;
}

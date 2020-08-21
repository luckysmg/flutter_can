import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CommentBoxState> buildReducer() {
  return asReducer(
    <Object, Reducer<CommentBoxState>>{
      CommentBoxAction.updateCollect: _updateCollect,
      CommentBoxAction.updateLike: _updateLike,
    },
  );
}

CommentBoxState _updateCollect(CommentBoxState state, Action action) {
  int newNum = action.payload['newCollectNum'];
  bool status = action.payload['status'];
  final CommentBoxState newState = state.clone();
  newState.detailData.data.collectionStatus = status ? "YES" : "NO";
  newState.detailData.data.collectionNumber = newNum as int;
  return newState;
}

CommentBoxState _updateLike(CommentBoxState state, Action action) {
  int newNum = action.payload['newLikeNum'];
  bool status = action.payload['status'];
  final CommentBoxState newState = state.clone();
  newState.detailData.data.likeStatus = status ? "YES" : "NO";
  newState.detailData.data.likeNumber = newNum as int;
  return newState;
}

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CommentBoxState> buildReducer() {
  return asReducer(
    <Object, Reducer<CommentBoxState>>{
      CommentBoxAction.update: _updateCollect,
      CommentBoxAction.updateCollect: _updateCollect,
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

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<BookDetailBottomState> buildReducer() {
  return asReducer(
    <Object, Reducer<BookDetailBottomState>>{
      BookDetailBottomAction.collect: _collect,
    },
  );
}

BookDetailBottomState _collect(BookDetailBottomState state, Action action) {
  int newCollectionNum = action.payload['newCollectionNum'];
  String status = action.payload['status'];
  final BookDetailBottomState newState = state.clone();
  newState.bookDetailData.data.collectionNumber = newCollectionNum;
  newState.bookDetailData.data.collectionStatus = status;
  return newState;
}

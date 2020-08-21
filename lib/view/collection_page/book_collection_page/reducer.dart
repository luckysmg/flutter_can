import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<BookCollectionState> buildReducer() {
  return asReducer(
    <Object, Reducer<BookCollectionState>>{
      BookCollectionAction.action: _onAction,
    },
  );
}

BookCollectionState _onAction(BookCollectionState state, Action action) {
  final BookCollectionState newState = state.clone();
  return newState;
}

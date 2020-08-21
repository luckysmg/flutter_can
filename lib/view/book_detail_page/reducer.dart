import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<BookDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<BookDetailState>>{
      BookDetailAction.update: _update,
    },
  );
}

BookDetailState _update(BookDetailState state, Action action) {
  final BookDetailState newState = state.clone();
  return newState;
}

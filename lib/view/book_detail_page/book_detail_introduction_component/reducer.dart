import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<BookDetailIntroductionState> buildReducer() {
  return asReducer(
    <Object, Reducer<BookDetailIntroductionState>>{
      BookDetailIntroductionAction.action: _onAction,
    },
  );
}

BookDetailIntroductionState _onAction(
    BookDetailIntroductionState state, Action action) {
  final BookDetailIntroductionState newState = state.clone();
  return newState;
}

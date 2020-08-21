import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CommentState> buildReducer() {
  return asReducer(
    <Object, Reducer<CommentState>>{
      CommentAction.update: _update,
    },
  );
}

CommentState _update(CommentState state, Action action) {
  final CommentState newState = state.clone();
  return newState;
}

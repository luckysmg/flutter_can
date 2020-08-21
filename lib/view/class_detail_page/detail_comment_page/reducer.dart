import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DetailCommentState> buildReducer() {
  return asReducer(
    <Object, Reducer<DetailCommentState>>{
      DetailCommentAction.update: _update,
    },
  );
}

DetailCommentState _update(DetailCommentState state, Action action) {
  final DetailCommentState newState = state.clone();
  return newState;
}

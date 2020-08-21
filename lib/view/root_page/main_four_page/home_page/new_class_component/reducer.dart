import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<NewClassState> buildReducer() {
  return asReducer(
    <Object, Reducer<NewClassState>>{
      NewClassAction.action: _onAction,
    },
  );
}

NewClassState _onAction(NewClassState state, Action action) {
  final NewClassState newState = state.clone();
  return newState;
}

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RootState> buildReducer() {
  return asReducer(
    <Object, Reducer<RootState>>{
      RootAction.action: _onAction,
    },
  );
}

RootState _onAction(RootState state, Action action) {
  final RootState newState = state.clone();
  return newState;
}

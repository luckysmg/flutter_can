import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LeftState> buildReducer() {
  return asReducer(
    <Object, Reducer<LeftState>>{
      LeftAction.switchIndex: _switchIndex,
    },
  );
}

LeftState _switchIndex(LeftState state, Action action) {
  final LeftState newState = state.clone();
  newState.currentIndex = action.payload;
  return newState;
}

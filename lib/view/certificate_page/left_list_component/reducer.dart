import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LeftListState> buildReducer() {
  return asReducer(
    <Object, Reducer<LeftListState>>{
      LeftListAction.switchIndex: _switchIndex,
    },
  );
}

LeftListState _switchIndex(LeftListState state, Action action) {
  int currentIndex = action.payload;
  final LeftListState newState = state.clone();
  newState.currentIndex = currentIndex;
  return newState;
}

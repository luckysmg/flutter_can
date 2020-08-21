import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ClassLeftState> buildReducer() {
  return asReducer(
    <Object, Reducer<ClassLeftState>>{
      ClassLeftAction.switchIndex: _switchIndex,
    },
  );
}

ClassLeftState _switchIndex(ClassLeftState state, Action action) {
  int currentIndex = action.payload;
  final ClassLeftState newState = state.clone();
  newState.currentIndex = currentIndex;
  return newState;
}

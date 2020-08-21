import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AllBookState> buildReducer() {
  return asReducer(
    <Object, Reducer<AllBookState>>{
      AllBookAction.action: _onAction,
    },
  );
}

AllBookState _onAction(AllBookState state, Action action) {
  final AllBookState newState = state.clone();
  return newState;
}

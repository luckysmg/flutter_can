import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AllNewClassState> buildReducer() {
  return asReducer(
    <Object, Reducer<AllNewClassState>>{
      AllNewClassAction.action: _onAction,
    },
  );
}

AllNewClassState _onAction(AllNewClassState state, Action action) {
  final AllNewClassState newState = state.clone();
  return newState;
}

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AllClassicalClassState> buildReducer() {
  return asReducer(
    <Object, Reducer<AllClassicalClassState>>{
      AllClassicalClassAction.action: _onAction,
    },
  );
}

AllClassicalClassState _onAction(AllClassicalClassState state, Action action) {
  final AllClassicalClassState newState = state.clone();
  return newState;
}

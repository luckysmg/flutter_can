import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SelectProfessionState> buildReducer() {
  return asReducer(
    <Object, Reducer<SelectProfessionState>>{
      SelectProfessionAction.action: _onAction,
    },
  );
}

SelectProfessionState _onAction(SelectProfessionState state, Action action) {
  final SelectProfessionState newState = state.clone();
  return newState;
}

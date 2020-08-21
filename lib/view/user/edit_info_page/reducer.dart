import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<EditInfoState> buildReducer() {
  return asReducer(
    <Object, Reducer<EditInfoState>>{EditInfoAction.updateUI: _updateUI},
  );
}

EditInfoState _updateUI(EditInfoState state, Action action) {
  final EditInfoState newState = state.clone();
  return newState;
}

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LoginState> buildReducer() {
  return asReducer(
    <Object, Reducer<LoginState>>{
      LoginAction.updateUI: _updateUI,
    },
  );
}

LoginState _updateUI(LoginState state, Action action) {
  final LoginState newState = state.clone();
  newState.canClickButton = action.payload['isClick'];
  newState.showClearIcon = action.payload['showClearIcon'];
  return newState;
}

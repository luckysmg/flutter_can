import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AllGalaxySelectState> buildReducer() {
  return asReducer(
    <Object, Reducer<AllGalaxySelectState>>{
      AllGalaxySelectAction.action: _onAction,
    },
  );
}

AllGalaxySelectState _onAction(AllGalaxySelectState state, Action action) {
  final AllGalaxySelectState newState = state.clone();
  return newState;
}

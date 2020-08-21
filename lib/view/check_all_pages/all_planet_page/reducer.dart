import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AllPlanetState> buildReducer() {
  return asReducer(
    <Object, Reducer<AllPlanetState>>{
      AllPlanetAction.action: _onAction,
    },
  );
}

AllPlanetState _onAction(AllPlanetState state, Action action) {
  final AllPlanetState newState = state.clone();
  return newState;
}

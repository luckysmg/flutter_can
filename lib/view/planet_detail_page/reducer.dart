import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PlanetDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<PlanetDetailState>>{
      PlanetDetailAction.action: _onAction,
    },
  );
}

PlanetDetailState _onAction(PlanetDetailState state, Action action) {
  final PlanetDetailState newState = state.clone();
  return newState;
}

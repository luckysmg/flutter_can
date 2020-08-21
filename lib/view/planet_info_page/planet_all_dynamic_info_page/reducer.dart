import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PlanetAllDynamicInfoState> buildReducer() {
  return asReducer(
    <Object, Reducer<PlanetAllDynamicInfoState>>{},
  );
}

PlanetAllDynamicInfoState _onAction(
    PlanetAllDynamicInfoState state, Action action) {
  final PlanetAllDynamicInfoState newState = state.clone();
  return newState;
}

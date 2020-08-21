import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AllGalaxyState> buildReducer() {
  return asReducer(
    <Object, Reducer<AllGalaxyState>>{
      AllGalaxyAction.action: _onAction,
    },
  );
}

AllGalaxyState _onAction(AllGalaxyState state, Action action) {
  final AllGalaxyState newState = state.clone();
  return newState;
}

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GalaxyDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<GalaxyDetailState>>{
      GalaxyDetailAction.action: _onAction,
    },
  );
}

GalaxyDetailState _onAction(GalaxyDetailState state, Action action) {
  final GalaxyDetailState newState = state.clone();
  return newState;
}

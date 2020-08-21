import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DiscoverState> buildReducer() {
  return asReducer(
    <Object, Reducer<DiscoverState>>{
      DiscoverAction.update: _update,
    },
  );
}

DiscoverState _update(DiscoverState state, Action action) {
  final DiscoverState newState = state.clone();
  return newState;
}

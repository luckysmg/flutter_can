import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeState>>{
      HomeAction.update: _update,
    },
  );
}

HomeState _update(HomeState state, Action action) {
  final HomeState newState = state.clone();
  return newState;
}

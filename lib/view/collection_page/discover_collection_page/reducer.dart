import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DiscoverCollectionState> buildReducer() {
  return asReducer(
    <Object, Reducer<DiscoverCollectionState>>{
      DiscoverCollectionAction.update: _update,
    },
  );
}

DiscoverCollectionState _update(DiscoverCollectionState state, Action action) {
  final DiscoverCollectionState newState = state.clone();
  return newState;
}

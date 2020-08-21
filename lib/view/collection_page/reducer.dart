import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CollectionState> buildReducer() {
  return asReducer(
    <Object, Reducer<CollectionState>>{
      CollectionAction.action: _onAction,
      CollectionAction.init: _init,
    },
  );
}

CollectionState _onAction(CollectionState state, Action action) {
  final CollectionState newState = state.clone();
  return newState;
}

CollectionState _init(CollectionState state, Action action) {
  final CollectionState newState = state.clone();
  newState.tabController = action.payload;
  return newState;
}

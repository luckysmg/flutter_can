import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AllFreeClassState> buildReducer() {
  return asReducer(
    <Object, Reducer<AllFreeClassState>>{
      AllFreeClassAction.action: _onAction,
    },
  );
}

AllFreeClassState _onAction(AllFreeClassState state, Action action) {
  final AllFreeClassState newState = state.clone();
  return newState;
}

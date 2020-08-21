import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ClassListState> buildReducer() {
  return asReducer(
    <Object, Reducer<ClassListState>>{
      ClassListAction.action: _onAction,
    },
  );
}

ClassListState _onAction(ClassListState state, Action action) {
  final ClassListState newState = state.clone();
  return newState;
}

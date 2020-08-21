import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ClassState> buildReducer() {
  return asReducer(
    <Object, Reducer<ClassState>>{
      ClassAction.action: _onAction,
    },
  );
}

ClassState _onAction(ClassState state, Action action) {
  final ClassState newState = state.clone();
  return newState;
}

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ClassCollectionState> buildReducer() {
  return asReducer(
    <Object, Reducer<ClassCollectionState>>{
      ClassCollectionAction.update: _update,
    },
  );
}

ClassCollectionState _update(ClassCollectionState state, Action action) {
  final ClassCollectionState newState = state.clone();
  return newState;
}

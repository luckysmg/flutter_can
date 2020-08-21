import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ClassDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<ClassDetailState>>{
//      ClassDetailAction.updateUrl: _update,
    },
  );
}

//ClassDetailState _update(ClassDetailState state, Action action) {
//  final videoUrl = action.payload;
//  final ClassDetailState newState = state.clone();
//
//  return newState;
//}

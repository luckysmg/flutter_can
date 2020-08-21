import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ProfessionDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<ProfessionDetailState>>{},
  );
}

ProfessionDetailState _onAction(ProfessionDetailState state, Action action) {
  final ProfessionDetailState newState = state.clone();
  return newState;
}

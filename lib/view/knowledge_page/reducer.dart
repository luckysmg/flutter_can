import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<KnowledgeState> buildReducer() {
  return asReducer(
    <Object, Reducer<KnowledgeState>>{
      KnowledgeAction.update: _update,
    },
  );
}

KnowledgeState _update(KnowledgeState state, Action action) {
  final KnowledgeState newState = state.clone();
  return newState;
}

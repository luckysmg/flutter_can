import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AllRecommendClassState> buildReducer() {
  return asReducer(
    <Object, Reducer<AllRecommendClassState>>{
      AllRecommendClassAction.action: _onAction,
    },
  );
}

AllRecommendClassState _onAction(AllRecommendClassState state, Action action) {
  final AllRecommendClassState newState = state.clone();
  return newState;
}

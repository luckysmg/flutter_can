import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AllCertificateState> buildReducer() {
  return asReducer(
    <Object, Reducer<AllCertificateState>>{
      AllCertificateAction.action: _onAction,
    },
  );
}

AllCertificateState _onAction(AllCertificateState state, Action action) {
  final AllCertificateState newState = state.clone();
  return newState;
}

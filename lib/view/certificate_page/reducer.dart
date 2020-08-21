import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CertificateState> buildReducer() {
  return asReducer(
    <Object, Reducer<CertificateState>>{
      CertificateAction.update: _update,
    },
  );
}

CertificateState _update(CertificateState state, Action action) {
  final CertificateState newState = state.clone();
  return newState;
}

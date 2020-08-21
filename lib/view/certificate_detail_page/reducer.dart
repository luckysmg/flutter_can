import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CertificateDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<CertificateDetailState>>{
      CertificateDetailAction.update: _update,
    },
  );
}

CertificateDetailState _update(CertificateDetailState state, Action action) {
  final CertificateDetailState newState = state.clone();
  return newState;
}

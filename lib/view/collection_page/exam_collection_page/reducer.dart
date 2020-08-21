import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CertificateCollectionState> buildReducer() {
  return asReducer(
    <Object, Reducer<CertificateCollectionState>>{
      CertificateCollectionAction.action: _onAction,
    },
  );
}

CertificateCollectionState _onAction(
    CertificateCollectionState state, Action action) {
  final CertificateCollectionState newState = state.clone();
  return newState;
}

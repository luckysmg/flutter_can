import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/base_state.dart';

class CertificateCollectionState
    with BaseState
    implements Cloneable<CertificateCollectionState> {
  @override
  CertificateCollectionState clone() {
    return CertificateCollectionState()..hasNetworkError = hasNetworkError;
  }
}

CertificateCollectionState initState(Map<String, dynamic> args) {
  return CertificateCollectionState();
}

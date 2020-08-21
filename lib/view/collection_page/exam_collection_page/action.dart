import 'package:fish_redux/fish_redux.dart';

enum CertificateCollectionAction { action }

class CertificateCollectionActionCreator {
  static Action onAction() {
    return const Action(CertificateCollectionAction.action);
  }
}

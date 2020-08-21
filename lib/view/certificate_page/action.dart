import 'package:fish_redux/fish_redux.dart';

enum CertificateAction {
  init,
  update,
}

class CertificateActionCreator {
  static Action init() {
    return const Action(CertificateAction.init);
  }

  static Action update() {
    return const Action(CertificateAction.update);
  }
}

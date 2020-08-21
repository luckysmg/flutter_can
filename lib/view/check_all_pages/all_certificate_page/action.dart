import 'package:fish_redux/fish_redux.dart';

enum AllCertificateAction { action, loadMore }

class AllCertificateActionCreator {
  static Action onAction() {
    return const Action(AllCertificateAction.action);
  }

  static Action loadMore() {
    return const Action(AllCertificateAction.loadMore);
  }
}

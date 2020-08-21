import 'package:fish_redux/fish_redux.dart';

enum CertificateDetailAction {
  init,
  update,
  scrollToComment,
  loadMore,
  refreshCommentList,
  switchSchedulesIndex
}

class CertificateDetailActionCreator {
  static Action init() {
    return const Action(CertificateDetailAction.init);
  }

  static Action update() {
    return const Action(CertificateDetailAction.update);
  }

  static Action scrollToComment() {
    return const Action(CertificateDetailAction.scrollToComment);
  }

  static Action loadMore() {
    return const Action(CertificateDetailAction.loadMore);
  }

  static Action refreshCommentList() {
    return const Action(CertificateDetailAction.refreshCommentList);
  }

  static Action switchSchedulesIndex(int index) {
    return Action(CertificateDetailAction.switchSchedulesIndex, payload: index);
  }
}

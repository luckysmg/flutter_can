import 'package:fish_redux/fish_redux.dart';

enum ClassDetailAction {
  init,
  updateUrl,
}

class ClassDetailActionCreator {
  static Action init() {
    return const Action(ClassDetailAction.init);
  }

  static Action updateUrl(String videoUrl) {
    return Action(ClassDetailAction.updateUrl, payload: videoUrl);
  }
}

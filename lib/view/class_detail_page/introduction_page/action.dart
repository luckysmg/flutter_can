import 'package:fish_redux/fish_redux.dart';

enum IntroductionAction { action, collect, changeUrl }

class IntroductionActionCreator {
  static Action onAction() {
    return const Action(IntroductionAction.action);
  }

  static Action collect() {
    return const Action(IntroductionAction.collect);
  }

  static Action changeUrl(String url) {
    return Action(IntroductionAction.changeUrl, payload: url);
  }
}

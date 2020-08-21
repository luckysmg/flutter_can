import 'package:fish_redux/fish_redux.dart';

enum AllBookAction { action, loadMore }

class AllBookActionCreator {
  static Action onAction() {
    return const Action(AllBookAction.action);
  }

  static Action loadMore() {
    return const Action(AllBookAction.loadMore);
  }
}

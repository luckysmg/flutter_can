import 'package:fish_redux/fish_redux.dart';

enum HomeAction {
  update,
  loadMore,
  scrollToTop,
}

class HomeActionCreator {
  static Action update() {
    return const Action(HomeAction.update);
  }

  static Action loadMore() {
    return Action(HomeAction.loadMore);
  }

  static Action scrollToTop() {
    return const Action(HomeAction.scrollToTop);
  }
}

import 'package:fish_redux/fish_redux.dart';

enum DiscoverListAction { reload, updateReload, loadMore, updateLoadMore }

class DiscoverListActionCreator {
  static Action reload() {
    return const Action(DiscoverListAction.reload);
  }

  static Action updateReload(Map map) {
    return Action(DiscoverListAction.updateReload, payload: map);
  }

  static Action loadMore() {
    return const Action(DiscoverListAction.loadMore);
  }

  static Action updateLoadMore(Map map) {
    return Action(DiscoverListAction.updateLoadMore, payload: map);
  }
}

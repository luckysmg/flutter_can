import 'package:fish_redux/fish_redux.dart';

enum DiscoverCollectionAction {
  ///初始化+下拉刷新
  init,

  ///加载更多
  loadMore,

  ///刷新状态
  update
}

class DiscoverCollectionActionCreator {
  static Action update() {
    return Action(DiscoverCollectionAction.update);
  }

  static Action init() {
    return Action(DiscoverCollectionAction.init);
  }

  static Action loadMore() {
    return Action(DiscoverCollectionAction.loadMore);
  }
}

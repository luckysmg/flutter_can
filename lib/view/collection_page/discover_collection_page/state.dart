import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/collection_discover_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DiscoverCollectionState
    with BaseState
    implements Cloneable<DiscoverCollectionState> {
  CollectionDiscoverEntity data;
  int currentPage;
  RefreshController refreshController;

  @override
  DiscoverCollectionState clone() {
    return DiscoverCollectionState()
      ..hasNetworkError = hasNetworkError
      ..data = data
      ..currentPage = currentPage
      ..refreshController = refreshController;
  }
}

DiscoverCollectionState initState(Map<String, dynamic> args) {
  return DiscoverCollectionState()
    ..currentPage = 1
    ..refreshController = RefreshController();
}

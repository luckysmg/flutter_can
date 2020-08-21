import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/discover_list_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DiscoverListState implements Cloneable<DiscoverListState> {
  int currentPage;
  RefreshController refreshController;
  DiscoverListEntity discoverListData;

  @override
  DiscoverListState clone() {
    return DiscoverListState()
      ..refreshController = refreshController
      ..currentPage = currentPage
      ..discoverListData = discoverListData;
  }
}

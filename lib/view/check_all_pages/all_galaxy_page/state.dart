import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/galaxy_class_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllGalaxyState with BaseState implements Cloneable<AllGalaxyState> {
  int currentPage;
  RefreshController refreshController;
  GalaxyClassEntity galaxyCategoryData;

  @override
  AllGalaxyState clone() {
    return AllGalaxyState()
      ..hasNetworkError = hasNetworkError
      ..refreshController = refreshController
      ..currentPage = currentPage
      ..galaxyCategoryData = galaxyCategoryData;
  }
}

AllGalaxyState initState(Map<String, dynamic> args) {
  return AllGalaxyState()
    ..currentPage = 1
    ..refreshController = RefreshController();
}

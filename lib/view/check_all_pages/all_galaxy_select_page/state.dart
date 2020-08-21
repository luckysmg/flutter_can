import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/galaxy_class_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllGalaxySelectState
    with BaseState
    implements Cloneable<AllGalaxySelectState> {
  int currentPage;
  RefreshController refreshController;
  GalaxyClassEntity galaxyCategoryData;

  @override
  AllGalaxySelectState clone() {
    return AllGalaxySelectState()
      ..hasNetworkError = hasNetworkError
      ..refreshController = refreshController
      ..currentPage = currentPage
      ..galaxyCategoryData = galaxyCategoryData;
  }
}

AllGalaxySelectState initState(Map<String, dynamic> args) {
  return AllGalaxySelectState()
    ..currentPage = 1
    ..refreshController = RefreshController();
}

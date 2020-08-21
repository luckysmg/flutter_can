import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/home_class_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllClassicalClassState
    with BaseState
    implements Cloneable<AllClassicalClassState> {
  int currentPage;
  RefreshController refreshController;
  HomeClassEntity freeClassData;

  @override
  AllClassicalClassState clone() {
    return AllClassicalClassState()
      ..hasNetworkError = hasNetworkError
      ..currentPage = currentPage
      ..refreshController = refreshController
      ..freeClassData = freeClassData;
  }
}

AllClassicalClassState initState(Map<String, dynamic> args) {
  return AllClassicalClassState()
    ..currentPage = 1
    ..refreshController = RefreshController();
}

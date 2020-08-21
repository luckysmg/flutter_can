import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/home_class_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllFreeClassState with BaseState implements Cloneable<AllFreeClassState> {
  int currentPage;
  RefreshController refreshController;
  HomeClassEntity freeClassData;

  @override
  AllFreeClassState clone() {
    return AllFreeClassState()
      ..hasNetworkError = hasNetworkError
      ..currentPage = currentPage
      ..refreshController = refreshController
      ..freeClassData = freeClassData;
  }
}

AllFreeClassState initState(Map<String, dynamic> args) {
  return AllFreeClassState()
    ..currentPage = 1
    ..refreshController = RefreshController();
}

import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/home_class_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllNewClassState with BaseState implements Cloneable<AllNewClassState> {
  int currentPage;
  RefreshController refreshController;
  HomeClassEntity freeClassData;

  @override
  AllNewClassState clone() {
    return AllNewClassState()
      ..hasNetworkError = hasNetworkError
      ..currentPage = currentPage
      ..refreshController = refreshController
      ..freeClassData = freeClassData;
    ;
  }
}

AllNewClassState initState(Map<String, dynamic> args) {
  return AllNewClassState()
    ..refreshController = RefreshController()
    ..currentPage = 1;
}

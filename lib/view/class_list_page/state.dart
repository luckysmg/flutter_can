import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/home_class_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClassListState with BaseState implements Cloneable<ClassListState> {
  String oid;
  String title;
  int currentPage;
  RefreshController refreshController;
  HomeClassEntity classData;

  @override
  ClassListState clone() {
    return ClassListState()
      ..title = title
      ..oid = oid
      ..hasNetworkError = hasNetworkError
      ..currentPage = currentPage
      ..refreshController = refreshController
      ..classData = classData;
  }
}

ClassListState initState(Map<String, dynamic> args) {
  return ClassListState()
    ..title = args['title']
    ..oid = args['oid']
    ..refreshController = RefreshController()
    ..currentPage = 1;
}

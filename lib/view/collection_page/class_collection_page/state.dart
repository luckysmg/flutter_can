import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/collection_class_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClassCollectionState
    with BaseState
    implements Cloneable<ClassCollectionState> {
  CollectionClassEntity data;
  int currentPage;
  RefreshController refreshController;

  @override
  ClassCollectionState clone() {
    return ClassCollectionState()
      ..hasNetworkError = hasNetworkError
      ..data = data
      ..currentPage = currentPage
      ..refreshController = refreshController;
  }
}

ClassCollectionState initState(Map<String, dynamic> args) {
  return ClassCollectionState()
    ..currentPage = 1
    ..refreshController = RefreshController();
}

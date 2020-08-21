import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/exact_level_class_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllRecommendClassState
    with BaseState
    implements Cloneable<AllRecommendClassState> {
  int currentPage;
  RefreshController refreshController;
  ExactLevelClassEntity classEntity;
  String level;
  String title;

  @override
  AllRecommendClassState clone() {
    return AllRecommendClassState()
      ..hasNetworkError = hasNetworkError
      ..classEntity = classEntity
      ..level = level
      ..title = title
      ..currentPage = currentPage
      ..refreshController = refreshController;
  }
}

AllRecommendClassState initState(Map<String, dynamic> args) {
  return AllRecommendClassState()
    ..refreshController = RefreshController()
    ..currentPage = 1
    ..level = args['level']
    ..title = args['title'];
}

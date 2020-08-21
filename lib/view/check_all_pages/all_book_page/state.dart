import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/recommend_book_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllBookState with BaseState implements Cloneable<AllBookState> {
  int currentPage;
  RecommendBookEntity recommendBookData;
  RefreshController refreshController;

  @override
  AllBookState clone() {
    return AllBookState()
      ..hasNetworkError = hasNetworkError
      ..currentPage = currentPage
      ..recommendBookData = recommendBookData
      ..refreshController = refreshController;
  }
}

AllBookState initState(Map<String, dynamic> args) {
  return AllBookState()
    ..currentPage = 1
    ..refreshController = RefreshController();
}

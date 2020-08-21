import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/entity/check_planet_in_galaxy_entity.dart';
import 'package:neng/entity/discover_list_entity.dart';
import 'package:neng/entity/galaxy_class_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:neng/view/root_page/main_four_page/discover_page/discover_list_component/state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DiscoverState with BaseState implements Cloneable<DiscoverState> {
  GalaxyClassEntity tabCategoriesData;
  int currentPage;
  DiscoverListEntity discoverListData;
  RefreshController refreshController;
  ScrollController scrollController;
  CheckPlanetInGalaxyEntity planetInGalaxyListData;

  ///是否已经绑定事件
  bool hasEventBind;

  @override
  DiscoverState clone() {
    return DiscoverState()
      ..tabCategoriesData = tabCategoriesData
      ..hasNetworkError = hasNetworkError
      ..planetInGalaxyListData = planetInGalaxyListData
      ..currentPage = currentPage
      ..discoverListData = discoverListData
      ..scrollController = scrollController
      ..hasEventBind = hasEventBind
      ..refreshController = refreshController;
  }
}

DiscoverState initState(Map<String, dynamic> args) {
  return DiscoverState()
    ..currentPage = 1
    ..hasEventBind = false
    ..scrollController = ScrollController()
    ..refreshController = RefreshController();
}

class DiscoverListConnector extends ConnOp<DiscoverState, DiscoverListState> {
  @override
  DiscoverListState get(DiscoverState state) {
    final DiscoverListState subState = DiscoverListState();
    subState.currentPage = state.currentPage;
    subState.refreshController = state.refreshController;
    subState.discoverListData = state.discoverListData;
    return subState;
  }

  @override
  void set(DiscoverState state, DiscoverListState subState) {
    state.refreshController = subState.refreshController;
    state.currentPage = subState.currentPage;
    state.discoverListData = subState.discoverListData;
  }
}

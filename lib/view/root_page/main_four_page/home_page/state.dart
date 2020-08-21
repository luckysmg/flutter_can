import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/entity/home_banner_entity.dart';
import 'package:neng/entity/home_class_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'banner_component/state.dart';
import 'new_class_component/state.dart';

class HomeState with BaseState implements Cloneable<HomeState> {
  ScrollController scrollController;

  ///banner的实时索引
  int bannerCurrentIndex;

  ///banner数据
  HomeBannerEntity bannerData;
  RefreshController refreshController;
  int currentPage;
  HomeClassEntity freeClassData;
  HomeClassEntity goodClassData;
  HomeClassEntity newClassData;

  @override
  HomeState clone() {
    return HomeState()
      ..bannerData = bannerData
      ..bannerCurrentIndex = bannerCurrentIndex
      ..hasNetworkError = hasNetworkError
      ..refreshController = refreshController
      ..currentPage = currentPage
      ..freeClassData = freeClassData
      ..goodClassData = goodClassData
      ..newClassData = newClassData
      ..scrollController = scrollController;
  }
}

HomeState initState(Map<String, dynamic> args) {
  return HomeState()
    ..scrollController = ScrollController()
    ..bannerCurrentIndex = 0
    ..refreshController = RefreshController()
    ..currentPage = 1;
}

///banner 的conn
class BannerConnector extends ConnOp<HomeState, BannerState> {
  @override
  BannerState get(HomeState state) {
    final BannerState subState = BannerState();
    subState.bannerData = state.bannerData;
    subState.currentIndex = state.bannerCurrentIndex;
    return subState;
  }

  @override
  void set(HomeState state, BannerState subState) {
    state.bannerData = subState.bannerData;
    state.bannerCurrentIndex = subState.currentIndex;
  }
}

///上新课程的conn
class NewClassConnector extends ConnOp<HomeState, NewClassState> {
  @override
  NewClassState get(HomeState state) {
    final NewClassState subState = NewClassState();
    subState.newClassData = state.newClassData;
    return subState;
  }

  @override
  void set(HomeState state, NewClassState subState) {
    state.newClassData = subState.newClassData;
  }
}

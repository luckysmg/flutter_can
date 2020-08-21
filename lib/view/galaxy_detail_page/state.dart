import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/entity/discover_list_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GalaxyDetailState with BaseState implements Cloneable<GalaxyDetailState> {
  String oid;
  String title;
  int currentPage;
  RefreshController refreshController;
  DiscoverListEntity discoverListData;
  ScrollController scrollController;

  @override
  GalaxyDetailState clone() {
    return GalaxyDetailState()
      ..hasNetworkError = hasNetworkError
      ..title = title
      ..scrollController = scrollController
      ..oid = oid
      ..refreshController = refreshController
      ..currentPage = currentPage
      ..discoverListData = discoverListData;
  }
}

GalaxyDetailState initState(Map<String, dynamic> args) {
  return GalaxyDetailState()
    ..scrollController = ScrollController()
    ..oid = args['oid']
    ..title = args['title']
    ..refreshController = RefreshController()
    ..currentPage = 1;
}

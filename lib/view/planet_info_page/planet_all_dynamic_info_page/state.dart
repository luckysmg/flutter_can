import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/planet_dynamic_list_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PlanetAllDynamicInfoState
    with BaseState
    implements Cloneable<PlanetAllDynamicInfoState> {
  String oid;
  RefreshController refreshController;
  int currentPage;
  bool enableLoadMore;

  ///列表数据
  PlanetDynamicListEntity listEntity;

  @override
  PlanetAllDynamicInfoState clone() {
    return PlanetAllDynamicInfoState()
      ..oid = oid
      ..enableLoadMore = enableLoadMore
      ..refreshController = refreshController
      ..currentPage = currentPage
      ..listEntity = listEntity;
  }
}

PlanetAllDynamicInfoState initState(Map<String, dynamic> args) {
  return PlanetAllDynamicInfoState()
    ..oid = args['oid']
    ..enableLoadMore = args['enableLoadMore']
    ..refreshController = RefreshController()
    ..currentPage = 1;
}

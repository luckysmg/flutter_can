import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/discover_list_entity.dart';

import 'action.dart';
import 'state.dart';

Reducer<DiscoverListState> buildReducer() {
  return asReducer(
    <Object, Reducer<DiscoverListState>>{
      DiscoverListAction.updateLoadMore: _updateLoadMore,
      DiscoverListAction.updateReload: _updateReload,
    },
  );
}

DiscoverListState _updateReload(DiscoverListState state, Action action) {
  DiscoverListEntity newData = action.payload['newData'];
  final DiscoverListState newState = state.clone();
  newState.discoverListData = newData;
  newState.currentPage = 1;
  return newState;
}

DiscoverListState _updateLoadMore(DiscoverListState state, Action action) {
  DiscoverListEntity nextPageData = action.payload['listData'];
  int currentPage = action.payload['currentPage'];
  final DiscoverListState newState = state.clone();
  newState.discoverListData.rows.addAll(nextPageData.rows);
  newState.currentPage = currentPage + 1;
  return newState;
}

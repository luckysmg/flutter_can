import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/home_banner_entity.dart';

import 'action.dart';
import 'state.dart';

Reducer<BannerState> buildReducer() {
  return asReducer(
    <Object, Reducer<BannerState>>{
      BannerAction.init: _init,
      BannerAction.switchIndex: _switchIndex,
    },
  );
}

BannerState _init(BannerState state, Action action) {
  HomeBannerEntity data = action.payload;
  final BannerState newState = state.clone();
  newState.bannerData = data;
  return newState;
}

BannerState _switchIndex(BannerState state, Action action) {
  final BannerState newState = state.clone();
  int currentIndex = action.payload;
  newState.currentIndex = currentIndex;
  return newState;
}

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PublishDynamicInfoState> buildReducer() {
  return asReducer(
    <Object, Reducer<PublishDynamicInfoState>>{},
  );
}

PublishDynamicInfoState _getPhotos(
    PublishDynamicInfoState state, Action action) {
  final PublishDynamicInfoState newState = state.clone();
  return newState;
}

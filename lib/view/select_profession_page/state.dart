import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/entity/profession_list_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:neng/view/select_profession_page/left_component/state.dart';
import 'package:neng/view/select_profession_page/right_component/state.dart';

class SelectProfessionState
    with BaseState
    implements Cloneable<SelectProfessionState> {
  ///现在左边被选中条目的index
  int currentIndex;
  ProfessionListEntity professionListData;
  ScrollController rightScrollController;
  bool isFromSettingPage;

  @override
  SelectProfessionState clone() {
    return SelectProfessionState()
      ..rightScrollController = rightScrollController
      ..hasNetworkError = hasNetworkError
      ..currentIndex = currentIndex
      ..professionListData = professionListData
      ..isFromSettingPage = isFromSettingPage;
  }
}

SelectProfessionState initState(Map<String, dynamic> args) {
  return SelectProfessionState()
    ..currentIndex = 0
    ..rightScrollController = ScrollController()
    ..isFromSettingPage = args['isFromSettingPage'] ?? true;
}

class LeftConnector extends ConnOp<SelectProfessionState, LeftState> {
  @override
  LeftState get(SelectProfessionState state) {
    final LeftState subState = LeftState();
    subState.professionListData = state.professionListData;
    subState.currentIndex = state.currentIndex;
    return subState;
  }

  @override
  void set(SelectProfessionState state, LeftState subState) {
    state.currentIndex = subState.currentIndex;
    state.professionListData = subState.professionListData;
  }
}

class RightConnector extends ConnOp<SelectProfessionState, RightState> {
  @override
  RightState get(SelectProfessionState state) {
    final RightState subState = RightState();
    subState.professionListData = state.professionListData;
    subState.currentIndex = state.currentIndex;
    subState.scrollController = state.rightScrollController;
    subState.isFromSettingPage = state.isFromSettingPage;
    return subState;
  }

  @override
  void set(SelectProfessionState state, RightState subState) {
    state.rightScrollController = subState.scrollController;
    state.currentIndex = subState.currentIndex;
    state.isFromSettingPage = subState.isFromSettingPage;
    state.professionListData = subState.professionListData;
  }
}

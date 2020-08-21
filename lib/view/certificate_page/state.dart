import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/entity/certification_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:neng/view/certificate_page/left_list_component/state.dart';
import 'package:neng/view/certificate_page/right_list_component/state.dart';

class CertificateState with BaseState implements Cloneable<CertificateState> {
  ///现在左边被选中条目的index
  int currentIndex;
  CertificationEntity certificationData;
  ScrollController rightScrollController;

  @override
  CertificateState clone() {
    return CertificateState()
      ..currentIndex = currentIndex
      ..hasNetworkError = hasNetworkError
      ..certificationData = certificationData
      ..rightScrollController = rightScrollController;
  }
}

CertificateState initState(Map<String, dynamic> args) {
  return CertificateState()
    ..currentIndex = 0
    ..rightScrollController = ScrollController();
}

///左边list的conn
class LeftListConnector extends ConnOp<CertificateState, LeftListState> {
  @override
  LeftListState get(CertificateState state) {
    final LeftListState subState = LeftListState()
      ..currentIndex = state.currentIndex
      ..certificationData = state.certificationData;
    return subState;
  }

  @override
  void set(CertificateState state, LeftListState subState) {
    state.certificationData = subState.certificationData;
    state.currentIndex = subState.currentIndex;
  }
}

///右边内容的conn
class RightListConnector extends ConnOp<CertificateState, RightListState> {
  @override
  RightListState get(CertificateState state) {
    final RightListState subState = RightListState()
      ..currentIndex = state.currentIndex
      ..certificationData = state.certificationData
      ..scrollController = state.rightScrollController;
    return subState;
  }

  @override
  void set(CertificateState state, RightListState subState) {
    state.certificationData = subState.certificationData;
    state.currentIndex = subState.currentIndex;
    state.rightScrollController = subState.scrollController;
  }
}

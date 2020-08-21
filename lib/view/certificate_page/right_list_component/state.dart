import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/entity/certification_entity.dart';

class RightListState implements Cloneable<RightListState> {
  ///左边被选中条目的index
  int currentIndex;
  CertificationEntity certificationData;
  ScrollController scrollController;

  @override
  RightListState clone() {
    return RightListState()
      ..currentIndex = currentIndex
      ..certificationData = certificationData
      ..scrollController = scrollController;
  }
}

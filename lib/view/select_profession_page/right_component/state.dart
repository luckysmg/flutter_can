import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:neng/entity/profession_list_entity.dart';

class RightState implements Cloneable<RightState> {
  ///正在展示的index
  int currentIndex;
  ScrollController scrollController;
  ProfessionListEntity professionListData;
  String professionName;
  String professionCode;
  bool isFromSettingPage;

  @override
  RightState clone() {
    return RightState()
      ..professionName = professionName
      ..professionCode = professionCode
      ..professionListData = professionListData
      ..currentIndex = currentIndex
      ..scrollController = scrollController
      ..isFromSettingPage = isFromSettingPage;
  }
}

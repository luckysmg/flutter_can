import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/entity/home_class_list_entity.dart';
import 'package:neng/entity/recommend_book_entity.dart';
import 'package:neng/entity/recommend_certification_entity.dart';
import 'package:neng/entity/recommend_profession_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfessionState with BaseState implements Cloneable<ProfessionState> {
  HomeClassListEntity homeClassListData;
  RefreshController refreshController;
  RecommendProfessionEntity recommendProfessionData;
  RecommendBookEntity recommendBookData;
  RecommendCertificationEntity recommendCertificationData;
  bool expanded;
  bool isUserLogin;
  ScrollController scrollController;

  @override
  ProfessionState clone() {
    return ProfessionState()
      ..recommendCertificationData = recommendCertificationData
      ..recommendProfessionData = recommendProfessionData
      ..hasNetworkError = hasNetworkError
      ..homeClassListData = homeClassListData
      ..refreshController = refreshController
      ..recommendBookData = recommendBookData
      ..expanded = expanded
      ..isUserLogin = isUserLogin
      ..scrollController = scrollController;
  }
}

ProfessionState initState(Map<String, dynamic> args) {
  return ProfessionState()
    ..refreshController = RefreshController()
    ..expanded = false
    ..isUserLogin = UserProfileUtil.isUserLogin()
    ..scrollController = ScrollController();
}

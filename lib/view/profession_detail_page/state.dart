import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/home_class_list_entity.dart';
import 'package:neng/entity/recommend_book_entity.dart';
import 'package:neng/entity/recommend_certification_entity.dart';
import 'package:neng/entity/recommend_profession_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfessionDetailState
    with BaseState
    implements Cloneable<ProfessionDetailState> {
  String professionOid;
  String professionName;
  RefreshController refreshController;
  HomeClassListEntity homeClassListData;
  RecommendProfessionEntity recommendProfessionData;
  RecommendBookEntity recommendBookData;
  RecommendCertificationEntity recommendCertificationData;
  bool expanded;

  @override
  ProfessionDetailState clone() {
    return ProfessionDetailState()
      ..hasNetworkError = hasNetworkError
      ..professionOid = professionOid
      ..professionName = professionName
      ..recommendCertificationData = recommendCertificationData
      ..recommendProfessionData = recommendProfessionData
      ..hasNetworkError = hasNetworkError
      ..homeClassListData = homeClassListData
      ..refreshController = refreshController
      ..recommendBookData = recommendBookData
      ..expanded = expanded;
  }
}

ProfessionDetailState initState(Map<String, dynamic> args) {
  return ProfessionDetailState()
    ..professionOid = args['oid']
    ..professionName = args['professionName']
    ..refreshController = RefreshController()
    ..expanded = false;
}

import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/recommend_certification_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllCertificateState
    with BaseState
    implements Cloneable<AllCertificateState> {
  int currentPage;
  RecommendCertificationEntity recommendCertificationData;
  RefreshController refreshController;

  @override
  AllCertificateState clone() {
    return AllCertificateState()
      ..hasNetworkError = hasNetworkError
      ..currentPage = currentPage
      ..recommendCertificationData = recommendCertificationData
      ..refreshController = refreshController;
  }
}

AllCertificateState initState(Map<String, dynamic> args) {
  return AllCertificateState()
    ..refreshController = RefreshController()
    ..currentPage = 1;
}

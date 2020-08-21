import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/knowledge_list_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class KnowledgeState with BaseState implements Cloneable<KnowledgeState> {
  var currentPage;
  KnowledgeListEntity knowledgeListEntity;

  RefreshController refreshController;

  @override
  KnowledgeState clone() {
    return KnowledgeState()
      ..hasNetworkError = hasNetworkError
      ..knowledgeListEntity = knowledgeListEntity
      ..refreshController = refreshController
      ..currentPage = currentPage;
  }
}

KnowledgeState initState(Map<String, dynamic> args) {
  return KnowledgeState()
    ..currentPage = 1
    ..refreshController = RefreshController();
}

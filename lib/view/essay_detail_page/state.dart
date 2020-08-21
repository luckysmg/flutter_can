import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/entity/comment_list_entity.dart';
import 'package:neng/entity/essay_detail_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EssayDetailState with BaseState implements Cloneable<EssayDetailState> {
  ///动态的oid
  String oid;

  int currentPage;
  RefreshController refreshController;

  EssayDetailEntity data;
  CommentListEntity commentListData;
  FocusNode focusNode;
  TextEditingController textEditingController;

  @override
  EssayDetailState clone() {
    return EssayDetailState()
      ..hasNetworkError = hasNetworkError
      ..currentPage = currentPage
      ..refreshController = refreshController
      ..oid = oid
      ..textEditingController = textEditingController
      ..focusNode = focusNode
      ..data = data
      ..commentListData = commentListData;
  }
}

EssayDetailState initState(Map<String, dynamic> args) {
  return EssayDetailState()
    ..oid = args['oid']
    ..refreshController = RefreshController()
    ..currentPage = 1
    ..focusNode = FocusNode()
    ..textEditingController = TextEditingController();
}

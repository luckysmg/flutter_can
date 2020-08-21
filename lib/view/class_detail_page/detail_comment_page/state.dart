import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/entity/comment_list_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailCommentState
    with BaseState
    implements Cloneable<DetailCommentState> {
  String oid;
  CommentListEntity commentListData;
  int currentPage;
  FocusNode focusNode;
  TextEditingController textEditingController;
  RefreshController refreshController;

  @override
  DetailCommentState clone() {
    return DetailCommentState()
      ..hasNetworkError = hasNetworkError
      ..commentListData = commentListData
      ..oid = oid
      ..currentPage = currentPage
      ..refreshController = refreshController
      ..textEditingController = textEditingController
      ..focusNode = focusNode;
  }
}

DetailCommentState initState(Map<String, dynamic> args) {
  return DetailCommentState()
    ..oid = args['oid']
    ..currentPage = 1
    ..textEditingController = TextEditingController()
    ..focusNode = FocusNode()
    ..refreshController = RefreshController();
}

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/entity/certification_detail_entity.dart';
import 'package:neng/entity/comment_list_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:neng/view/certificate_detail_page/comment_list_component/state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'comment_box_component/state.dart';

class CertificateDetailState
    with BaseState
    implements Cloneable<CertificateDetailState> {
  CertificationDetailEntity detailData;
  CommentListEntity commentsData;
  String oid;
  String title;
  TextEditingController textEditingController;
  FocusNode focusNode;
  RefreshController refreshController;
  int currentPage;
  bool dataHasResp;
  ScrollController scrollController;

  ///时间安排的选择的index
  var currentIndex;

  @override
  CertificateDetailState clone() {
    return CertificateDetailState()
      ..oid = oid
      ..title = title
      ..detailData = detailData
      ..textEditingController = textEditingController
      ..hasNetworkError = hasNetworkError
      ..commentsData = commentsData
      ..refreshController = refreshController
      ..focusNode = focusNode
      ..currentPage = currentPage
      ..dataHasResp = dataHasResp
      ..scrollController = scrollController
      ..currentIndex = currentIndex;
  }
}

CertificateDetailState initState(Map<String, dynamic> args) {
  return CertificateDetailState()
    ..currentPage = 1
    ..oid = args['oid']
    ..title = args['title']
    ..refreshController = RefreshController()
    ..focusNode = FocusNode()
    ..textEditingController = TextEditingController()
    ..dataHasResp = false
    ..scrollController = ScrollController()
    ..currentIndex = 0;
}

class CommentBoxConnector
    extends ConnOp<CertificateDetailState, CommentBoxState> {
  @override
  CommentBoxState get(CertificateDetailState state) {
    final CommentBoxState subState = CommentBoxState();
    subState.oid = state.oid;
    subState.focusNode = state.focusNode;
    subState.textEditingController = state.textEditingController;
    subState.detailData = state.detailData;
    subState.commentData = state.commentsData;
    return subState;
  }

  @override
  void set(CertificateDetailState state, CommentBoxState subState) {
    state.detailData = subState.detailData;
    state.textEditingController = subState.textEditingController;
    state.commentsData = subState.commentData;
    state.focusNode = subState.focusNode;
    state.oid = subState.oid;
  }
}

class CommentListConnector
    extends ConnOp<CertificateDetailState, CommentListState> {
  @override
  CommentListState get(CertificateDetailState state) {
    final CommentListState subState = CommentListState();
    subState.commentsData = state.commentsData;
    return subState;
  }

  @override
  void set(CertificateDetailState state, CommentListState subState) {
    state.commentsData = subState.commentsData;
  }
}

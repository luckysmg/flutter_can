import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/entity/comment_list_entity.dart';
import 'package:neng/entity/discover_item_detail_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:neng/view/discover_detail_page/comment_box_component/state.dart';
import 'package:neng/view/discover_detail_page/comment_list_component/state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DiscoverDetailState
    with BaseState
    implements Cloneable<DiscoverDetailState> {
  String oid;
  DiscoverItemDetailEntity detailData;
  CommentListEntity commentsData;
  TextEditingController textEditingController;
  FocusNode focusNode;
  ScrollController scrollController;
  RefreshController refreshController;
  int currentPage;

  @override
  DiscoverDetailState clone() {
    return DiscoverDetailState()
      ..oid = oid
      ..commentsData = commentsData
      ..detailData = detailData
      ..hasNetworkError = hasNetworkError
      ..textEditingController = textEditingController
      ..focusNode = focusNode
      ..scrollController = scrollController
      ..refreshController = refreshController
      ..currentPage = currentPage;
  }
}

DiscoverDetailState initState(Map<String, dynamic> args) {
  String oid = args['oid'];
  return DiscoverDetailState()
    ..oid = oid
    ..textEditingController = TextEditingController()
    ..focusNode = FocusNode()
    ..scrollController = ScrollController()
    ..refreshController = RefreshController()
    ..currentPage = 1;
}

///=================================================================

///下方评论列表的conn
class CommentListConnector
    extends ConnOp<DiscoverDetailState, CommentListState> {
  @override
  CommentListState get(DiscoverDetailState state) {
    final CommentListState subState = CommentListState();
    subState.commentsData = state.commentsData;
    return subState;
  }

  @override
  void set(DiscoverDetailState state, CommentListState subState) {
    state.commentsData = subState.commentsData;
  }
}

///悬浮在下方的评论框conn
class CommentBoxConnector extends ConnOp<DiscoverDetailState, CommentBoxState> {
  @override
  CommentBoxState get(DiscoverDetailState state) {
    final CommentBoxState subState = CommentBoxState();
    subState.oid = state.oid;
    subState.focusNode = state.focusNode;
    subState.textEditingController = state.textEditingController;
    subState.detailData = state.detailData;
    subState.commentData = state.commentsData;
    return subState;
  }

  @override
  void set(DiscoverDetailState state, CommentBoxState subState) {
    state.detailData = subState.detailData;
    state.textEditingController = subState.textEditingController;
    state.commentsData = subState.commentData;
    state.focusNode = subState.focusNode;
    state.oid = subState.oid;
  }
}

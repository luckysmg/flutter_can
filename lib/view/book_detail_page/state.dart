import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:neng/entity/book_detail_entity.dart';
import 'package:neng/entity/comment_list_entity.dart';
import 'package:neng/redux/base_state.dart';
import 'package:neng/view/book_detail_page/book_detail_bottom_component/state.dart';
import 'package:neng/view/book_detail_page/book_detail_introduction_component/state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'book_detail_comment_list_component/state.dart';

class BookDetailState with BaseState implements Cloneable<BookDetailState> {
  String oid;
  int currentPage;
  BookDetailEntity bookDetailData;
  CommentListEntity commentsData;
  TextEditingController textEditingController;
  FocusNode focusNode;
  RefreshController refreshController;

  @override
  BookDetailState clone() {
    return BookDetailState()
      ..hasNetworkError = hasNetworkError
      ..oid = oid
      ..currentPage = currentPage
      ..refreshController = refreshController
      ..bookDetailData = bookDetailData
      ..commentsData = commentsData
      ..focusNode = focusNode
      ..textEditingController = textEditingController;
  }
}

BookDetailState initState(Map<String, dynamic> args) {
  return BookDetailState()
    ..oid = args['oid']
    ..textEditingController = TextEditingController()
    ..focusNode = FocusNode()
    ..currentPage = 1
    ..refreshController = RefreshController();
}

class BookDetailIntroductionConnector
    extends ConnOp<BookDetailState, BookDetailIntroductionState> {
  @override
  BookDetailIntroductionState get(BookDetailState state) {
    final BookDetailIntroductionState subState = BookDetailIntroductionState();
    subState.bookDetailData = state.bookDetailData;
    return subState;
  }

  @override
  void set(BookDetailState state, BookDetailIntroductionState subState) {
    state.bookDetailData = subState.bookDetailData;
  }
}

class BookDetailBottomConnector
    extends ConnOp<BookDetailState, BookDetailBottomState> {
  @override
  BookDetailBottomState get(BookDetailState state) {
    final BookDetailBottomState subState = BookDetailBottomState();
    subState.bookDetailData = state.bookDetailData;
    subState.focusNode = state.focusNode;
    subState.commentsData = state.commentsData;
    subState.textEditingController = state.textEditingController;
    subState.bid = state.oid;
    return subState;
  }

  @override
  void set(BookDetailState state, BookDetailBottomState subState) {
    state.bookDetailData = subState.bookDetailData;
    state.commentsData = subState.commentsData;
    state.focusNode = subState.focusNode;
    state.oid = subState.bid;
    state.textEditingController = subState.textEditingController;
  }
}

class BookDetailCommentListConnector
    extends ConnOp<BookDetailState, BookDetailCommentListState> {
  @override
  BookDetailCommentListState get(BookDetailState state) {
    final BookDetailCommentListState subState = BookDetailCommentListState();
    subState.commentsData = state.commentsData;
    subState.oid = state.oid;
    return subState;
  }

  @override
  void set(BookDetailState state, BookDetailCommentListState subState) {
    state.commentsData = subState.commentsData;
  }
}

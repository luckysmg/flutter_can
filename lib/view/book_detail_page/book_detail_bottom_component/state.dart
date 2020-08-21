import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/entity/book_detail_entity.dart';
import 'package:neng/entity/comment_list_entity.dart';

class BookDetailBottomState implements Cloneable<BookDetailBottomState> {
  String bid;
  BookDetailEntity bookDetailData;
  CommentListEntity commentsData;
  TextEditingController textEditingController;
  FocusNode focusNode;

  @override
  BookDetailBottomState clone() {
    return BookDetailBottomState()
      ..bid = bid
      ..bookDetailData = bookDetailData
      ..commentsData = commentsData
      ..textEditingController = textEditingController
      ..focusNode = focusNode;
  }
}

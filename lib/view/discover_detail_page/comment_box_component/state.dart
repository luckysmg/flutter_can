import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/entity/comment_list_entity.dart';
import 'package:neng/entity/discover_item_detail_entity.dart';

class CommentBoxState implements Cloneable<CommentBoxState> {
  String oid;
  DiscoverItemDetailEntity detailData;
  TextEditingController textEditingController;
  CommentListEntity commentData;
  FocusNode focusNode;

  @override
  CommentBoxState clone() {
    return CommentBoxState()
      ..oid = oid
      ..textEditingController = textEditingController
      ..detailData = detailData
      ..focusNode = focusNode
      ..commentData = commentData;
  }
}

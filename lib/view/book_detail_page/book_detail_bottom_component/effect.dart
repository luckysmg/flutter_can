import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:neng/entity/collection_entity.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/view/book_detail_page/book_detail_comment_list_component/action.dart';

import 'action.dart';
import 'state.dart';

Effect<BookDetailBottomState> buildEffect() {
  return combineEffects(<Object, Effect<BookDetailBottomState>>{
    BookDetailBottomAction.addComment: _addComment,
    BookDetailBottomAction.onCollect: _onCollect,
  });
}

void _addComment(Action action, Context<BookDetailBottomState> ctx) {
  DioUtil.getInstance().doPost<SimpleEntity>(
      url: API.add_comment,
      context: ctx.context,
      param: {
        'bid': ctx.state.bid,
        'type': 'BOOK',
        'descript': ctx.state.textEditingController.text
      },
      onSuccess: (data) {
        ctx.state.textEditingController.text = '';
        ToastUtil.show("评论成功");
        ctx.dispatch(BookDetailCommentListActionCreator.onRefreshComment());
        Navigator.pop(ctx.context);
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

void _onCollect(Action action, Context<BookDetailBottomState> ctx) {
  bool hasCollected = ctx.state.bookDetailData.data.collectionStatus == 'YES';
  if (hasCollected) {
    DioUtil.getInstance().doPost<CollectionEntity>(
        url: API.cancel_collect_book + '/${ctx.state.bookDetailData.data.oid}',
        context: ctx.context,
        param: {'bookOid': ctx.state.bookDetailData.data.oid},
        onSuccess: (data) {
          ctx.dispatch(BookDetailBottomActionCreator.collect(
              {'newCollectionNum': data.collectionNumber, 'status': 'NO'}));
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  } else {
    DioUtil.getInstance().doPost<CollectionEntity>(
        url: API.collect_book,
        context: ctx.context,
        param: {
          'bookOid': ctx.state.bookDetailData.data.oid,
          'bookImage': ctx.state.bookDetailData.data.cover,
          'bookName': ctx.state.bookDetailData.data.name,
        },
        onSuccess: (data) {
          ctx.dispatch(BookDetailBottomActionCreator.collect(
              {'newCollectionNum': data.collectionNumber, 'status': 'YES'}));
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }
}

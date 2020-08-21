import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:neng/entity/collection_entity.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';

import '../action.dart';
import 'action.dart';
import 'state.dart';

Effect<CommentBoxState> buildEffect() {
  return combineEffects(<Object, Effect<CommentBoxState>>{
    CommentBoxAction.collect: collect,
    CommentBoxAction.addComment: _addComment,
  });
}

void collect(Action action, Context<CommentBoxState> ctx) {
  if (action.payload == false) {
    DioUtil.getInstance().doPost<CollectionEntity>(
        url: API.certification_collection,
        context: ctx.context,
        param: {
          'certificationOid': ctx.state.detailData.data.certificationOid,
          'certificationName': ctx.state.detailData.data.name,
        },
        onSuccess: (data) {
          int newCollectNum = data.collectionNumber;
          ctx.dispatch(CommentBoxActionCreator.updateCollect(
              {'newCollectNum': newCollectNum, 'status': true}));
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  } else {
    DioUtil.getInstance().doPost<CollectionEntity>(
        url: API.certification_cancel_collection + '/${ctx.state.oid}',
        context: ctx.context,
        onSuccess: (data) {
          int newCollectNum = data.collectionNumber;
          ctx.dispatch(CommentBoxActionCreator.updateCollect(
              {'newCollectNum': newCollectNum, 'status': false}));
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }
}

void _addComment(Action action, Context<CommentBoxState> ctx) {
  if (ctx.state.textEditingController.text.isNotEmpty) {
    DioUtil.getInstance().doPost<SimpleEntity>(
        url: API.add_comment,
        context: ctx.context,
        param: {
          'bid': ctx.state.oid,
          'type': 'CERTIFICATION',
          'descript': ctx.state.textEditingController.text,
        },
        onSuccess: (data) async {
          ctx.dispatch(CertificateDetailActionCreator.refreshCommentList());
          ctx.state.textEditingController.text = '';
          ctx.state.focusNode.unfocus();
          Navigator.pop(ctx.context);
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }
}

import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/collection_entity.dart';
import 'package:neng/entity/like_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/view/discover_detail_page/comment_box_component/action.dart';

import 'state.dart';

Effect<CommentBoxState> buildEffect() {
  return combineEffects(<Object, Effect<CommentBoxState>>{
    CommentBoxAction.onCollect: _onCollect,
    CommentBoxAction.onLike: _onLike,
  });
}

void _onCollect(Action action, Context<CommentBoxState> ctx) {
  if (action.payload == false) {
    DioUtil.getInstance().doPost<CollectionEntity>(
        url: API.discover_collection,
        context: ctx.context,
        param: {
          'discoverOid': ctx.state.oid,
          'discoverTitle': ctx.state.detailData.data.title,
          'commercialOid': ctx.state.detailData.data.createCommercialOid,
          'commercialName': ctx.state.detailData.data.createCommercialName,
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
        url: API.discover_cancel_collection + '/${ctx.state.oid}',
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

void _onLike(Action action, Context<CommentBoxState> ctx) {
  if (action.payload == false) {
    DioUtil.getInstance().doPost<LikeEntity>(
        url: API.discover_like,
        context: ctx.context,
        param: {
          'discoverOid': ctx.state.oid,
        },
        onSuccess: (data) {
          int newLikeNum = data.likeNumber;
          ctx.dispatch(CommentBoxActionCreator.updateLick(
              {'newLikeNum': newLikeNum, 'status': true}));
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  } else {
    DioUtil.getInstance().doPost<LikeEntity>(
        url: API.discover_cancel_like + '/${ctx.state.oid}',
        context: ctx.context,
        onSuccess: (data) {
          int newLikeNum = data.likeNumber;
          ctx.dispatch(CommentBoxActionCreator.updateLick(
              {'newLikeNum': newLikeNum, 'status': false}));
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }
}

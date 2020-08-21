import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:neng/entity/collection_entity.dart';
import 'package:neng/entity/comment_list_entity.dart';
import 'package:neng/entity/essay_detail_entity.dart';
import 'package:neng/entity/like_entity.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/dialog_util.dart';
import 'package:neng/util/image_util.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/view/essay_detail_page/action.dart';

import 'state.dart';

Effect<EssayDetailState> buildEffect() {
  return combineEffects(<Object, Effect<EssayDetailState>>{
    Lifecycle.initState: _init,
    EssayDetailAction.collect: _collect,
    EssayDetailAction.like: _like,
    EssayDetailAction.comment: _comment,
    EssayDetailAction.reloadCommentList: _reloadCommentList,
    EssayDetailAction.loadMore: _loadMore,
  });
}

void _init(Action action, Context<EssayDetailState> ctx) async {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    precacheImage(ImageUtil.getAssetImage('ico_praise'), ctx.context);
    precacheImage(ImageUtil.getAssetImage('ico_praise_empty'), ctx.context);
    precacheImage(ImageUtil.getAssetImage('ico_collect'), ctx.context);
    precacheImage(ImageUtil.getAssetImage('ico_collect_empty'), ctx.context);
  });

  ///查询详情数据
  var getDetailData = DioUtil.getInstance().doPost<EssayDetailEntity>(
      url: '${API.essay_detail}/${ctx.state.oid}',
      context: ctx.context,
      needDelay: true,
      onSuccess: (data) {
        ctx.state.data = data;
        ctx.forceUpdate();
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });

  ///查询评论List
  var getCommentData = DioUtil.getInstance().doPost<CommentListEntity>(
      url: API.comment_search,
      context: ctx.context,
      param: {
        'bid': ctx.state.oid,
        'size': 15,
        'page': ctx.state.currentPage,
        'type': 'ESSAY'
      },
      onSuccess: (data) {
        ctx.state.commentListData = data;
        PageUtil.updateAfterInitOrRefresh(
            controller: ctx.state.refreshController,
            responseDataCount: data.rows.length,
            totalCount: data.total);
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });
  await Future.wait([getDetailData, getCommentData]);
  ctx.forceUpdate();
}

void _collect(Action action, Context<EssayDetailState> ctx) {
  bool shouldCollect = ctx.state.data.collectionStatus == 'NO';
  if (shouldCollect) {
    DioUtil.getInstance().doPost<CollectionEntity>(
        url: API.essay_collect,
        context: ctx.context,
        param: {'essayOid': ctx.state.oid},
        onSuccess: (data) {
          ctx.state.data.collectionNumber = data.collectionNumber;
          ctx.state.data.collectionStatus = "YES";
          ctx.forceUpdate();
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  } else {
    DioUtil.getInstance().doPost<CollectionEntity>(
        url: '${API.essay_cancel_collect}/${ctx.state.oid}',
        context: ctx.context,
        onSuccess: (data) {
          ctx.state.data.collectionNumber = data.collectionNumber;
          ctx.state.data.collectionStatus = "NO";
          ctx.forceUpdate();
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }
}

void _like(Action action, Context<EssayDetailState> ctx) {
  bool shouldLike = ctx.state.data.likeStatus == 'NO';

  if (shouldLike) {
    DioUtil.getInstance().doPost<LikeEntity>(
        url: API.essay_like,
        context: ctx.context,
        param: {'essayOid': ctx.state.oid},
        onSuccess: (data) {
          ctx.state.data.likeStatus = 'YES';
          ctx.state.data.likeNumber = data.likeNumber;
          ctx.forceUpdate();
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  } else {
    DioUtil.getInstance().doPost<LikeEntity>(
        url: '${API.essay_unlike}/${ctx.state.oid}',
        context: ctx.context,
        onSuccess: (data) {
          ctx.state.data.likeStatus = 'NO';
          ctx.state.data.likeNumber = data.likeNumber;
          ctx.forceUpdate();
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }
}

void _comment(Action action, Context<EssayDetailState> ctx) {
  if (ctx.state.textEditingController.text.isNotEmpty) {
    DialogUtil.showLoadingDialog(context: ctx.context);
    DioUtil.getInstance().doPost<SimpleEntity>(
      url: API.add_comment,
      context: ctx.context,
      param: {
        'bid': ctx.state.oid,
        'type': 'ESSAY',
        'descript': ctx.state.textEditingController.text,
      },
      onSuccess: (data) async {
        ctx.state.textEditingController.text = '';
        ctx.state.focusNode.unfocus();
        DialogUtil.closeLoadingDialog(ctx.context);

        ///刷新评论列表
        ctx.dispatch(EssayDetailActionCreator.reloadCommentList());
        Navigator.pop(ctx.context);
      },
      onFailure: (e) {
        DialogUtil.closeLoadingDialog(ctx.context);
        ToastUtil.show(e.msg);
      },
    );
  }
}

///刷新评论列表
void _reloadCommentList(Action action, Context<EssayDetailState> ctx) {
  ctx.state.currentPage = 1;
  DioUtil.getInstance().doPost<CommentListEntity>(
      url: API.comment_search,
      context: ctx.context,
      param: {
        'bid': ctx.state.oid,
        'size': 15,
        'page': ctx.state.currentPage,
        'type': 'ESSAY'
      },
      onSuccess: (data) {
        ctx.state.commentListData = data;
        PageUtil.updateAfterInitOrRefresh(
            controller: ctx.state.refreshController,
            responseDataCount: data.rows.length,
            totalCount: data.total);
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });
}

void _loadMore(Action action, Context<EssayDetailState> ctx) {
  DioUtil.getInstance().doPost<CommentListEntity>(
      url: API.comment_search,
      context: ctx.context,
      param: {
        'bid': ctx.state.oid,
        'size': 15,
        'page': ctx.state.currentPage + 1,
        'type': 'ESSAY'
      },
      onSuccess: (data) {
        ctx.state.currentPage++;
        ctx.state.commentListData.rows.addAll(data.rows);
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: ctx.state.commentListData.rows.length,
            totalCount: data.total);
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

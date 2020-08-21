import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/comment_list_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'action.dart';
import 'state.dart';

Effect<BookDetailCommentListState> buildEffect() {
  return combineEffects(<Object, Effect<BookDetailCommentListState>>{
    BookDetailCommentListAction.onRefreshComment: _onRefreshComment,
  });
}

void _onRefreshComment(Action action, Context<BookDetailCommentListState> ctx) {
  var state = ctx.state;
  DioUtil.getInstance().doPost<CommentListEntity>(
      url: API.comment_search,
      context: ctx.context,
      param: {
        'size': 10,
        'page': 1,
        'type': 'BOOK',
        'bid': state.oid,
      },
      onSuccess: (data) {
        ctx.dispatch(BookDetailCommentListActionCreator.refreshComment(data));
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

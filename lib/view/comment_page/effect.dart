import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<CommentState> buildEffect() {
  return combineEffects(<Object, Effect<CommentState>>{
    Lifecycle.initState: _init,
    CommentAction.init: _init,
    CommentAction.loadMore: _loadMore,
  });
}

void _init(Action action, Context<CommentState> ctx) {
//  ctx.state.currentPage = 1;
//  DioUtil.getInstance().doPost(
//      url: API.comment_search,
//      context: ctx.context,
//      param: ,
//      onSuccess: (data) {
//        ctx.state.hasNetworkError = false;
//
//      },
//      onFailure: (e) {
//        if (e.networkError) {
//          ctx.state.hasNetworkError = true;
//          ctx.dispatch(CommentActionCreator.update());
//        }
//        TipUtil.showWaring(context: ctx.context, message: e.msg);
//      });
}

void _loadMore(Action action, Context<CommentState> ctx) {}

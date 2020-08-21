import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/knowledge_list_entity.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/view/knowledge_page/action.dart';

import 'state.dart';

Effect<KnowledgeState> buildEffect() {
  return combineEffects(<Object, Effect<KnowledgeState>>{
    Lifecycle.initState: _init,
    KnowledgeAction.loadMore: _loadMore,
    KnowledgeAction.reload: _init,
  });
}

void _init(Action action, Context<KnowledgeState> ctx) {
  GlobalStore.getEventBus().on<UserInfoChangeEvent>().listen((data) {
    _requestListData(ctx);
  });
  _requestListData(ctx);
}

///请求星球的列表数据
void _requestListData(Context<KnowledgeState> ctx) {
  ///如果用户登陆了才进行请求知识星球列表数据
  if (UserProfileUtil.isUserLogin()) {
    ctx.state.currentPage = 1;
    DioUtil.getInstance().doPost<KnowledgeListEntity>(
        url: API.knowledge_list,
        context: ctx.context,
        needDelay: true,
        param: {'page': ctx.state.currentPage, 'size': 15},
        onSuccess: (data) {
          ctx.state.knowledgeListEntity = data;
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
}

void _loadMore(Action action, Context<KnowledgeState> ctx) {
  DioUtil.getInstance().doPost<KnowledgeListEntity>(
      url: API.knowledge_list,
      context: ctx.context,
      param: {'page': ctx.state.currentPage + 1, 'size': 15},
      onSuccess: (data) {
        ctx.state.currentPage++;
        ctx.state.knowledgeListEntity.rows.addAll(data.rows);
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: ctx.state.knowledgeListEntity.rows.length,
            totalCount: data.total);
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

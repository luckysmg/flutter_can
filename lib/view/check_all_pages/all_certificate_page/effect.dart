import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/recommend_certification_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/page_util.dart';
import 'action.dart';
import 'state.dart';

Effect<AllCertificateState> buildEffect() {
  return combineEffects(<Object, Effect<AllCertificateState>>{
    Lifecycle.initState: _init,
    AllCertificateAction.loadMore: _loadMore,
  });
}

void _init(Action action, Context<AllCertificateState> ctx) {
  ctx.state.currentPage = 1;
  DioUtil.getInstance().doPost<RecommendCertificationEntity>(
      url: API.search_certification,
      context: ctx.context,
      needDelay: true,
      param: {'page': 1, 'size': 15},
      onSuccess: (data) {
        ctx.state.recommendCertificationData = data;
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

void _loadMore(Action action, Context<AllCertificateState> ctx) {
  DioUtil.getInstance().doPost<RecommendCertificationEntity>(
      url: API.search_book,
      context: ctx.context,
      needDelay: true,
      delayMills: Constants.delayLoadMore,
      param: {'page': ctx.state.currentPage + 1, 'size': 15},
      onSuccess: (data) {
        ctx.state.currentPage++;
        ctx.state.recommendCertificationData.rows.addAll(data.rows);
        PageUtil.updateAfterLoadMore(
            controller: ctx.state.refreshController,
            mergedDataCount: ctx.state.recommendCertificationData.rows.length,
            totalCount: data.total);
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.loadFailed(controller: ctx.state.refreshController);
      });
}

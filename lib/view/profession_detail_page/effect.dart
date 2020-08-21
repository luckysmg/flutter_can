import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/home_class_list_entity.dart';
import 'package:neng/entity/recommend_book_entity.dart';
import 'package:neng/entity/recommend_certification_entity.dart';
import 'package:neng/entity/recommend_profession_entity.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/entity/user_profile_entity.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/util/user_profile_util.dart';

import 'action.dart';
import 'state.dart';

Effect<ProfessionDetailState> buildEffect() {
  return combineEffects(<Object, Effect<ProfessionDetailState>>{
    Lifecycle.initState: _init,
    ProfessionDetailAction.init: _init,
    ProfessionDetailAction.selectProfession: _selectProfession,
    ProfessionDetailAction.switchExpanded: _switchExpanded
  });
}

void _switchExpanded(Action action, Context<ProfessionDetailState> ctx) {
  bool status = !ctx.state.expanded;
  ctx.state.expanded = status;
  ctx.forceUpdate();
}

void _init(Action action, Context<ProfessionDetailState> ctx) async {
  var getClassDetail = DioUtil.getInstance().doPost<HomeClassListEntity>(
      url: API.wiki_curriculum,
      context: ctx.context,
      needDelay: true,
      delayMills: 300,
      param: {'size': 4, 'professionOid': ctx.state.professionOid},
      onSuccess: (data) {
        ctx.state.hasNetworkError = false;
        ctx.state.homeClassListData = data;
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });

  var getRecommendProfessionDetail =
      DioUtil.getInstance().doPost<RecommendProfessionEntity>(
    url: API.wiki_recommend_profession,
    context: ctx.context,
    param: {'professionOid': ctx.state.professionOid},
    onSuccess: (data) {
      ctx.state.recommendProfessionData = data;
    },
  );

  var getBookDetail = DioUtil.getInstance().doPost<RecommendBookEntity>(
    url: API.wiki_recommend_book,
    context: ctx.context,
    param: {'page': 1, 'size': 6, 'professionOid': ctx.state.professionOid},
    onSuccess: (data) {
      ctx.state.recommendBookData = data;
    },
  );

  var getCertificationData =
      DioUtil.getInstance().doPost<RecommendCertificationEntity>(
    url: API.wiki_recommend_certification,
    context: ctx.context,
    param: {'page': 1, 'size': 8, 'professionOid': ctx.state.professionOid},
    onSuccess: (data) {
      ctx.state.recommendCertificationData = data;
    },
  );

  await Future.wait([
    getClassDetail,
    getRecommendProfessionDetail,
    getBookDetail,
    getCertificationData
  ]);
  ctx.state.refreshController.refreshCompleted();
  ctx.forceUpdate();
}

void _selectProfession(Action action, Context<ProfessionDetailState> ctx) {
  var professionName = action.payload['professionName'];
  var professionCode = action.payload['professionCode'];
  DioUtil.getInstance().doPost<SimpleEntity>(
      url: API.save_profession,
      param: {
        'professionName': professionName,
        'professionCode': professionCode,
      },
      context: ctx.context,
      onSuccess: (data) async {
        UserProfileEntity entity = UserProfileUtil.getUserDetailInfo();
        entity.professionName = professionName;
        entity.professionCode = professionCode;
        await UserProfileUtil.setUserDetailInfo(entity);
        GlobalStore.getEventBus().fire(UserInfoChangeEvent());

        ///直接跳转到首页
        NavigatorUtil.popToHome(ctx.context);
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/certification_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/tip_util.dart';

import 'action.dart';
import 'state.dart';

Effect<CertificateState> buildEffect() {
  return combineEffects(<Object, Effect<CertificateState>>{
    CertificateAction.init: _init,
    Lifecycle.initState: _init
  });
}

void _init(Action action, Context<CertificateState> ctx) {
  DioUtil.getInstance().doPost<CertificationEntity>(
      needDelay: true,
      delayMills: 300,
      url: API.search_all_certificate,
      context: ctx.context,
      onSuccess: (data) {
        ctx.state.hasNetworkError = false;
        ctx.state.certificationData = data;
        ctx.dispatch(CertificateActionCreator.update());
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });
}

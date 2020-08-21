import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/profession_list_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/page_util.dart';
import 'package:neng/util/tip_util.dart';

import 'action.dart';
import 'state.dart';

Effect<SelectProfessionState> buildEffect() {
  return combineEffects(<Object, Effect<SelectProfessionState>>{
    SelectProfessionAction.init: _init,
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<SelectProfessionState> ctx) {
  DioUtil.getInstance().doPost<ProfessionListEntity>(
      url: API.profession_list,
      context: ctx.context,
      needDelay: true,
      delayMills: Constants.delayInit,
      onSuccess: (data) {
        ctx.state.hasNetworkError = false;
        ctx.state.professionListData = data;
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });
}

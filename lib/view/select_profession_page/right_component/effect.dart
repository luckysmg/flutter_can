import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/entity/user_profile_entity.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/util/user_profile_util.dart';

import 'action.dart';
import 'state.dart';

Effect<RightState> buildEffect() {
  return combineEffects(<Object, Effect<RightState>>{
    RightAction.switchIndex: _switchIndex,
    RightAction.selectProfession: _selectProfession
  });
}

void _switchIndex(Action action, Context<RightState> ctx) {
  ctx.state.scrollController?.jumpTo(0);
}

void _selectProfession(Action action, Context<RightState> ctx) {
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
        Navigator.pop(ctx.context);
        Navigator.pop(ctx.context, true);
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

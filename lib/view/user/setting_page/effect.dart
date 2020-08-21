import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/dialog_util.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/user_profile_util.dart';

import 'action.dart';
import 'state.dart';

Effect<SettingState> buildEffect() {
  return combineEffects(<Object, Effect<SettingState>>{
    SettingAction.userLogout: _userLogout,
  });
}

void _userLogout(Action action, Context<SettingState> ctx) {
  DialogUtil.showDialog(
      dialogHeight: ScreenUtil().setHeight(250),
      context: ctx.context,
      title: '您确定要退出吗',
      onConfirm: () {
        UserProfileUtil.userLogOut();
        Navigator.pop(ctx.context);
        Navigator.pop(ctx.context);
      },
      onCancel: () => Navigator.pop(ctx.context));
}

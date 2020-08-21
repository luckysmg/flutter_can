import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' as widget;
import 'package:neng/store/global_store.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/image_util.dart';
import 'package:neng/util/user_profile_util.dart';

import 'action.dart';
import 'state.dart';

Effect<RootState> buildEffect() {
  return combineEffects(<Object, Effect<RootState>>{
    RootAction.action: _onAction,
    Lifecycle.initState: _init
  });
}

void _onAction(Action action, Context<RootState> ctx) {}

void _init(Action action, Context<RootState> ctx) {
  ///提前缓存图片避免闪动
  widget.WidgetsBinding.instance.addPostFrameCallback((_) {
    widget.precacheImage(ImageUtil.getAssetImage('ico_home'), ctx.context);
    widget.precacheImage(
        ImageUtil.getAssetImage('ico_home_selected'), ctx.context);
    widget.precacheImage(
        ImageUtil.getAssetImage('ico_profession_selected'), ctx.context);
    widget.precacheImage(
        ImageUtil.getAssetImage('ico_discover_selected'), ctx.context);
    widget.precacheImage(
        ImageUtil.getAssetImage('ico_me_selected'), ctx.context);

    widget.precacheImage(
        ImageUtil.getAssetImage(Constants.TIP_WARNING), ctx.context);
    widget.precacheImage(
        ImageUtil.getAssetImage(Constants.TIP_SUCCESS), ctx.context);

    if (!UserProfileUtil.isUserLogin() ||
        UserProfileUtil.getUserDetailInfo().headImageUrl == null) {
      widget.precacheImage(
          ImageUtil.getAssetImage('default/default_head'), ctx.context);
    }
  });
}

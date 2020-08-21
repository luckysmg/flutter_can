import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/curriculum_category_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/page_util.dart';

import 'action.dart';
import 'state.dart';

Effect<ClassState> buildEffect() {
  return combineEffects(<Object, Effect<ClassState>>{
    Lifecycle.initState: _init,
    ClassAction.init: _init,
  });
}

void _init(Action action, Context<ClassState> ctx) {
  DioUtil.getInstance().doPost<CurriculumCategoryEntity>(
      url: API.curriculum_category,
      context: ctx.context,
      needDelay: true,
      onSuccess: (data) {
        ctx.state.hasNetworkError = false;
        ctx.state.curriculumCategoryData = data;
        ctx.forceUpdate();
      },
      onFailure: (e) {
        PageUtil.initFail(ctx, e);
      });
}

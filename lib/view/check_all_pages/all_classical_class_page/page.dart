import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:首页->精品课->查看全部 进入此页面
///
class AllClassicalClassPage
    extends Page<AllClassicalClassState, Map<String, dynamic>> {
  AllClassicalClassPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AllClassicalClassState>(
              adapter: null,
              slots: <String, Dependent<AllClassicalClassState>>{}),
          effectMiddleware: <EffectMiddleware<AllClassicalClassState>>[
            networkErrorMiddleware(),
          ],
        );
}

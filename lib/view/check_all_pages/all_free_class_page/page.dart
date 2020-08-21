import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:首页->免费课程-> 查看全部进入此页面
///
class AllFreeClassPage extends Page<AllFreeClassState, Map<String, dynamic>> {
  AllFreeClassPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AllFreeClassState>(
              adapter: null, slots: <String, Dependent<AllFreeClassState>>{}),
          effectMiddleware: <EffectMiddleware<AllFreeClassState>>[
            networkErrorMiddleware(),
          ],
        );
}

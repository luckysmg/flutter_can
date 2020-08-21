import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:点击职业中的一个课程的查看全部（进阶课程->查看全部）
///
class AllRecommendClassPage
    extends Page<AllRecommendClassState, Map<String, dynamic>> {
  AllRecommendClassPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AllRecommendClassState>(
              adapter: null,
              slots: <String, Dependent<AllRecommendClassState>>{}),
          effectMiddleware: <EffectMiddleware<AllRecommendClassState>>[
            networkErrorMiddleware(),
          ],
        );
}

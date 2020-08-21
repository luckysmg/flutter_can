import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:发布动态页面
///
class PublishDynamicInfoPage
    extends Page<PublishDynamicInfoState, Map<String, dynamic>> {
  PublishDynamicInfoPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PublishDynamicInfoState>(
              adapter: null,
              slots: <String, Dependent<PublishDynamicInfoState>>{}),
          effectMiddleware: <EffectMiddleware<PublishDynamicInfoState>>[
            networkErrorMiddleware(),
          ],
        );
}

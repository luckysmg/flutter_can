import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:课程详情
///
class ClassDetailPage extends Page<ClassDetailState, Map<String, dynamic>>
    with SingleTickerProviderMixin {
  ClassDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ClassDetailState>(
              adapter: null, slots: <String, Dependent<ClassDetailState>>{}),
          effectMiddleware: <EffectMiddleware<ClassDetailState>>[
            networkErrorMiddleware(),
          ],
        );
}

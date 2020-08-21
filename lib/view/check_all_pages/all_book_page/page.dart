import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:书籍->查看全部
///
class AllBookPage extends Page<AllBookState, Map<String, dynamic>> {
  AllBookPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AllBookState>(
              adapter: null, slots: <String, Dependent<AllBookState>>{}),
          effectMiddleware: <EffectMiddleware<AllBookState>>[
            networkErrorMiddleware(),
          ],
        );
}

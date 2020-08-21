import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:查看所有星球,这个页面和AllGalaxyPage的区别就是这个页面是点击直接定居
///
class AllGalaxySelectPage
    extends Page<AllGalaxySelectState, Map<String, dynamic>> {
  AllGalaxySelectPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AllGalaxySelectState>(
              adapter: null,
              slots: <String, Dependent<AllGalaxySelectState>>{}),
          effectMiddleware: <EffectMiddleware<AllGalaxySelectState>>[
            networkErrorMiddleware(),
          ],
        );
}

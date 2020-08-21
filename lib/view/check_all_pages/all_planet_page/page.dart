import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:一个星系下面所有行星的页面
///
class AllPlanetPage extends Page<AllPlanetState, Map<String, dynamic>> {
  AllPlanetPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AllPlanetState>(
              adapter: null, slots: <String, Dependent<AllPlanetState>>{}),
          effectMiddleware: <EffectMiddleware<AllPlanetState>>[
            networkErrorMiddleware(),
          ],
        );
}

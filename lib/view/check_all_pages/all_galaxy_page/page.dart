import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:查看所有星球
///
class AllGalaxyPage extends Page<AllGalaxyState, Map<String, dynamic>> {
  AllGalaxyPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AllGalaxyState>(
              adapter: null, slots: <String, Dependent<AllGalaxyState>>{}),
          effectMiddleware: <EffectMiddleware<AllGalaxyState>>[
            networkErrorMiddleware(),
          ],
        );
}

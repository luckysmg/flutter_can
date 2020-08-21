import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:构建星球页面
///
class BuildPlanetPage extends Page<BuildPlanetState, Map<String, dynamic>> {
  BuildPlanetPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<BuildPlanetState>(
              adapter: null, slots: <String, Dependent<BuildPlanetState>>{}),
          middleware: <Middleware<BuildPlanetState>>[],
        );
}

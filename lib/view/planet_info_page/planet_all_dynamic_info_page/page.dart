import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:星球信息 全部 的列表页
///
class PlanetAllDynamicInfoPage
    extends Page<PlanetAllDynamicInfoState, Map<String, dynamic>> {
  PlanetAllDynamicInfoPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PlanetAllDynamicInfoState>(
              adapter: null,
              slots: <String, Dependent<PlanetAllDynamicInfoState>>{}),
          middleware: <Middleware<PlanetAllDynamicInfoState>>[],
        );
}

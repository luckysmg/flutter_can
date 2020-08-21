import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PlanetDetailPage extends Page<PlanetDetailState, Map<String, dynamic>> {
  PlanetDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PlanetDetailState>(
              adapter: null, slots: <String, Dependent<PlanetDetailState>>{}),
          middleware: <Middleware<PlanetDetailState>>[],
        );
}

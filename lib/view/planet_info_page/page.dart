import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';
import 'package:neng/view/planet_info_page/planet_info_header_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PlanetInfoPage extends Page<PlanetInfoState, Map<String, dynamic>> {
  PlanetInfoPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PlanetInfoState>(
              adapter: null,
              slots: <String, Dependent<PlanetInfoState>>{
                'header':
                    NoneConn<PlanetInfoState>() + PlanetInfoHeaderComponent(),
              }),
          effectMiddleware: <EffectMiddleware<PlanetInfoState>>[
            networkErrorMiddleware(),
          ],
        );
}

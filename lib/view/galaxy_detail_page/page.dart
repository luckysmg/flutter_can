import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';
import 'package:neng/view/galaxy_detail_page/list_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:星球详情页
///
class GalaxyDetailPage extends Page<GalaxyDetailState, Map<String, dynamic>> {
  GalaxyDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GalaxyDetailState>(
              adapter: null,
              slots: <String, Dependent<GalaxyDetailState>>{
                'list': NoneConn<GalaxyDetailState>() + ListComponent(),
              }),
          effectMiddleware: <EffectMiddleware<GalaxyDetailState>>[
            networkErrorMiddleware(),
          ],
        );
}

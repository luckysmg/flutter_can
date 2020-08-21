import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';
import 'package:neng/view/root_page/main_four_page/discover_page/discover_list_component/component.dart';
import 'package:neng/view/root_page/main_four_page/discover_page/top_header_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:发现页
///
class DiscoverPage extends Page<DiscoverState, Map<String, dynamic>>
    with SingleTickerProviderMixin<DiscoverState> {
  DiscoverPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DiscoverState>(
              adapter: null,
              slots: <String, Dependent<DiscoverState>>{
                ///头部组件
                'topHeader': NoneConn<DiscoverState>() + TopHeaderComponent(),

                ///文章列表
                'discoverList':
                    DiscoverListConnector() + DiscoverListComponent(),
              }),
          effectMiddleware: <EffectMiddleware<DiscoverState>>[
            networkErrorMiddleware(),
          ],
        );
}

import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';
import 'package:neng/view/root_page/main_four_page/home_page/banner_component/component.dart';

import 'category_buttons_component/component.dart';
import 'effect.dart';
import 'free_class_component/component.dart';
import 'good_class_component/component.dart';
import 'new_class_component/component.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HomePage extends Page<HomeState, Map<String, dynamic>>
    with SingleTickerProviderMixin {
  HomePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<HomeState>(
            adapter: null,
            slots: <String, Dependent<HomeState>>{
              ///轮播图
              'banner': BannerConnector() + BannerComponent(),
              'buttons': NoneConn<HomeState>() + CategoryButtonsComponent(),
              'freeClass': NoneConn<HomeState>() + FreeClassComponent(),
              'goodClass': NoneConn<HomeState>() + GoodClassComponent(),
              'newClass': NewClassConnector() + NewClassComponent(),
            },
          ),
          effectMiddleware: <EffectMiddleware<HomeState>>[
            networkErrorMiddleware(),
          ],
        );
}

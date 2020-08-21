import 'package:fish_redux/fish_redux.dart';
import 'package:neng/view/root_page/main_four_page/my_page/header_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MyPage extends Page<MyState, Map<String, dynamic>> {
  MyPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MyState>(
              adapter: null,
              slots: <String, Dependent<MyState>>{
                'header': HeaderConnector() + HeaderComponent(),
              }),
          middleware: <Middleware<MyState>>[],
        );
}

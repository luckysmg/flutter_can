import 'package:fish_redux/fish_redux.dart';
import 'package:neng/view/select_profession_page/left_component/component.dart';
import 'package:neng/view/select_profession_page/right_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SelectProfessionPage
    extends Page<SelectProfessionState, Map<String, dynamic>> {
  SelectProfessionPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SelectProfessionState>(
              slots: <String, Dependent<SelectProfessionState>>{
                'leftList': LeftConnector() + LeftComponent(),
                'rightList': RightConnector() + RightComponent(),
              }),
          middleware: <Middleware<SelectProfessionState>>[],
        );
}

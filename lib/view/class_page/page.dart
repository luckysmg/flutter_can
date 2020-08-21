import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'class_left_component/component.dart';
import 'class_right_component/component.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:精品课
///
class ClassPage extends Page<ClassState, Map<String, dynamic>> {
  ClassPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ClassState>(
              adapter: null,
              slots: <String, Dependent<ClassState>>{
                'leftList': ClassLeftConnector() + ClassLeftComponent(),
                'rightList': ClassRightConnector() + ClassRightComponent(),
              }),
          effectMiddleware: <EffectMiddleware<ClassState>>[
            networkErrorMiddleware(),
          ],
        );
}

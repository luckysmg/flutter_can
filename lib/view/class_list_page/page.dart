import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:精品课分类列表
///
class ClassListPage extends Page<ClassListState, Map<String, dynamic>> {
  ClassListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ClassListState>(
              adapter: null, slots: <String, Dependent<ClassListState>>{}),
//          middleware: <Middleware<ClassListState>>[],
          effectMiddleware: <EffectMiddleware<ClassListState>>[
            networkErrorMiddleware(),
          ],
        );
}

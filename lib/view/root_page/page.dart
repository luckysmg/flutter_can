import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:根页面
///
class RootPage extends Page<RootState, Map<String, dynamic>> {
  RootPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<RootState>(
            slots: <String, Dependent<RootState>>{},
          ),
        );
}

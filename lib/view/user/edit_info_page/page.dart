import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:编辑资料页面（我的->资料修改）
///
class EditInfoPage extends Page<EditInfoState, Map<String, dynamic>> {
  EditInfoPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<EditInfoState>(
              adapter: null, slots: <String, Dependent<EditInfoState>>{}),
          middleware: <Middleware<EditInfoState>>[],
        );
}

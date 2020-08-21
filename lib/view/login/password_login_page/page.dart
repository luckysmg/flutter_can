import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:登陆页面
///
class LoginPage extends Page<LoginState, Map<String, dynamic>> {
  LoginPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<LoginState>(
              adapter: null, slots: <String, Dependent<LoginState>>{}),
        );
}

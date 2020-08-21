import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///简介页
class IntroductionPage extends Page<IntroductionState, Map<String, dynamic>> {
  IntroductionPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IntroductionState>(
              adapter: null, slots: <String, Dependent<IntroductionState>>{}),
          middleware: <Middleware<IntroductionState>>[],
        );
}

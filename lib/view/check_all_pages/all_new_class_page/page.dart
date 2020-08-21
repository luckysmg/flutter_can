import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AllNewClassPage extends Page<AllNewClassState, Map<String, dynamic>> {
  AllNewClassPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AllNewClassState>(
              adapter: null, slots: <String, Dependent<AllNewClassState>>{}),
          effectMiddleware: <EffectMiddleware<AllNewClassState>>[
            networkErrorMiddleware(),
          ],
        );
}

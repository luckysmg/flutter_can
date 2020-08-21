import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';
import 'package:neng/redux/mixins.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ClassCollectionPage
    extends Page<ClassCollectionState, Map<String, dynamic>> {
  ClassCollectionPage()
      : super(
          wrapper: keepAliveWrapper,
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ClassCollectionState>(
              adapter: null,
              slots: <String, Dependent<ClassCollectionState>>{}),
          effectMiddleware: <EffectMiddleware<ClassCollectionState>>[
            networkErrorMiddleware(),
          ],
        );
}

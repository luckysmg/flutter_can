import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';
import 'package:neng/redux/mixins.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class BookCollectionPage
    extends Page<BookCollectionState, Map<String, dynamic>> {
  BookCollectionPage()
      : super(
          wrapper: keepAliveWrapper,
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<BookCollectionState>(
              adapter: null, slots: <String, Dependent<BookCollectionState>>{}),
          effectMiddleware: <EffectMiddleware<BookCollectionState>>[
            networkErrorMiddleware(),
          ],
        );
}

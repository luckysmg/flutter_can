import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:知识行星
///
class KnowledgePage extends Page<KnowledgeState, Map<String, dynamic>> {
  KnowledgePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<KnowledgeState>(
              adapter: null, slots: <String, Dependent<KnowledgeState>>{}),
          effectMiddleware: <EffectMiddleware<KnowledgeState>>[
            networkErrorMiddleware(),
          ],
        );
}

import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:课程评论列表页
///
class DetailCommentPage extends Page<DetailCommentState, Map<String, dynamic>> {
  DetailCommentPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DetailCommentState>(
              adapter: null, slots: <String, Dependent<DetailCommentState>>{}),
          effectMiddleware: <EffectMiddleware<DetailCommentState>>[
            networkErrorMiddleware(),
          ],
        );
}

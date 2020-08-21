import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';
import 'package:neng/view/discover_detail_page/comment_list_component/component.dart';

import 'comment_box_component/component.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:发现星球文章的详情页
///
class DiscoverDetailPage
    extends Page<DiscoverDetailState, Map<String, dynamic>> {
  DiscoverDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DiscoverDetailState>(
              adapter: null,
              slots: <String, Dependent<DiscoverDetailState>>{
                ///评论列表
                'commentsList': CommentListConnector() + CommentListComponent(),

                ///评论框
                'commentBox': CommentBoxConnector() + CommentBoxComponent(),
              }),
          effectMiddleware: <EffectMiddleware<DiscoverDetailState>>[
            networkErrorMiddleware(),
          ],
        );
}

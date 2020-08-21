import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';

import 'comment_box_component/component.dart';
import 'comment_list_component/component.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:考证的证书详情页面
///
class CertificateDetailPage
    extends Page<CertificateDetailState, Map<String, dynamic>> {
  CertificateDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<CertificateDetailState>(
              adapter: null,
              slots: <String, Dependent<CertificateDetailState>>{
                ///评论列表
                'commentsList': CommentListConnector() + CommentListComponent(),

                ///评论框
                'commentBox': CommentBoxConnector() + CommentBoxComponent(),
              }),
          effectMiddleware: <EffectMiddleware<CertificateDetailState>>[
            networkErrorMiddleware(),
          ],
        );
}

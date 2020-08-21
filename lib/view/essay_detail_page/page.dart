import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';
import 'package:neng/view/essay_detail_page/essay_bottom_bar_component/component.dart';
import 'package:neng/view/essay_detail_page/essay_comment_list_component/component.dart';
import 'package:neng/view/essay_detail_page/essay_detail_buttons_component/component.dart';
import 'package:neng/view/essay_detail_page/essay_detail_content_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:动态详情页
///
class EssayDetailPage extends Page<EssayDetailState, Map<String, dynamic>> {
  EssayDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<EssayDetailState>(
              adapter: null,
              slots: <String, Dependent<EssayDetailState>>{
                ///内容布局（除了评价列表之外的部分）
                'content': NoneConn<EssayDetailState>() +
                    EssayDetailContentComponent(),

                ///点赞和收藏两个按钮
                'buttons': NoneConn<EssayDetailState>() +
                    EssayDetailButtonsComponent(),

                ///底部栏
                'bottomBar':
                    NoneConn<EssayDetailState>() + EssayBottomBarComponent(),
                'commentList':
                    NoneConn<EssayDetailState>() + EssayCommentListComponent(),
              }),
          effectMiddleware: <EffectMiddleware<EssayDetailState>>[
            networkErrorMiddleware(),
          ],
        );
}

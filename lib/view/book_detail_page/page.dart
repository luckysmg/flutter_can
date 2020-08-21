import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';
import 'package:neng/view/book_detail_page/book_detail_bottom_component/component.dart';
import 'package:neng/view/book_detail_page/book_detail_introduction_component/component.dart';
import 'package:neng/view/book_detail_page/book_header_component/component.dart';

import 'book_detail_comment_list_component/component.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:书籍详情页
///
class BookDetailPage extends Page<BookDetailState, Map<String, dynamic>> {
  BookDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<BookDetailState>(
              slots: <String, Dependent<BookDetailState>>{
                'header': NoneConn<BookDetailState>() + BookHeaderComponent(),
                'introduction': BookDetailIntroductionConnector() +
                    BookDetailIntroductionComponent(),
                'bottom':
                    BookDetailBottomConnector() + BookDetailBottomComponent(),
                'commentList': BookDetailCommentListConnector() +
                    BookDetailCommentListComponent(),
              }),
          effectMiddleware: <EffectMiddleware<BookDetailState>>[
            networkErrorMiddleware(),
          ],
        );
}

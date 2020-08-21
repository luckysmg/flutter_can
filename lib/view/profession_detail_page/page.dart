import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';
import 'package:neng/view/profession_detail_page/recommend_book_component/component.dart';
import 'package:neng/view/profession_detail_page/recommend_certification_component/component.dart';
import 'package:neng/view/profession_detail_page/recommend_class_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:职业详情页
///
class ProfessionDetailPage
    extends Page<ProfessionDetailState, Map<String, dynamic>> {
  ProfessionDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ProfessionDetailState>(
              adapter: null,
              slots: <String, Dependent<ProfessionDetailState>>{
                'recommendClassList': NoneConn<ProfessionDetailState>() +
                    RecommendClassComponent(),
                'recommendBookList': NoneConn<ProfessionDetailState>() +
                    RecommendBookComponent(),
                'recommendCertificationList':
                    NoneConn<ProfessionDetailState>() +
                        RecommendCertificationComponent(),
              }),
          effectMiddleware: <EffectMiddleware<ProfessionDetailState>>[
            networkErrorMiddleware(),
          ],
        );
}

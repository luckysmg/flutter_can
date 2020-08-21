import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';
import 'package:neng/redux/mixins.dart';

import 'effect.dart';
import 'recommend_book_component/component.dart';
import 'recommend_certification_component/component.dart';
import 'recommend_class_component/component.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:职业页
///
class ProfessionPage extends Page<ProfessionState, Map<String, dynamic>> {
  ProfessionPage()
      : super(
          wrapper: keepAliveWrapper,
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ProfessionState>(
              adapter: null,
              slots: <String, Dependent<ProfessionState>>{
                'recommendClassList':
                    NoneConn<ProfessionState>() + RecommendClassComponent(),
                'recommendBookList':
                    NoneConn<ProfessionState>() + RecommendBookComponent(),
                'recommendCertificationList': NoneConn<ProfessionState>() +
                    RecommendCertificationComponent(),
              }),
          effectMiddleware: <EffectMiddleware<ProfessionState>>[
            networkErrorMiddleware(),
          ],
        );
}

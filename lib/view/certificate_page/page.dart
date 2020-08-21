import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';
import 'package:neng/view/certificate_page/left_list_component/component.dart';
import 'package:neng/view/certificate_page/right_list_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:考证页（首页->考证信息）
///
class CertificatePage extends Page<CertificateState, Map<String, dynamic>> {
  CertificatePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<CertificateState>(
            adapter: null,
            slots: <String, Dependent<CertificateState>>{
              'leftList': LeftListConnector() + LeftListComponent(),
              'rightList': RightListConnector() + RightListComponent(),
            },
          ),
          effectMiddleware: <EffectMiddleware<CertificateState>>[
            networkErrorMiddleware(),
          ],
        );
}

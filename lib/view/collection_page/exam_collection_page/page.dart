import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/middleware.dart';
import 'package:neng/redux/mixins.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:考证
///
class CertificateCollectionPage
    extends Page<CertificateCollectionState, Map<String, dynamic>> {
  CertificateCollectionPage()
      : super(
          wrapper: keepAliveWrapper,
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<CertificateCollectionState>(
              adapter: null,
              slots: <String, Dependent<CertificateCollectionState>>{}),
          effectMiddleware: <EffectMiddleware<CertificateCollectionState>>[
            networkErrorMiddleware(),
          ],
        );
}

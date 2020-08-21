import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:证书-》查看全部证书
///
class AllCertificatePage
    extends Page<AllCertificateState, Map<String, dynamic>> {
  AllCertificatePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AllCertificateState>(
              adapter: null, slots: <String, Dependent<AllCertificateState>>{}),
          middleware: <Middleware<AllCertificateState>>[],
        );
}

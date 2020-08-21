import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:星球信息的头部组件
///
class PlanetInfoHeaderComponent extends Component<PlanetInfoState> {
  PlanetInfoHeaderComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<PlanetInfoState>(
              adapter: null, slots: <String, Dependent<PlanetInfoState>>{}),
        );
}

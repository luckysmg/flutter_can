import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class RightComponent extends Component<RightState> {
  RightComponent()
      : super(
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<RightState>(
              adapter: null, slots: <String, Dependent<RightState>>{}),
        );
}

import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LeftComponent extends Component<LeftState> {
  LeftComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<LeftState>(
              adapter: null, slots: <String, Dependent<LeftState>>{}),
        );
}

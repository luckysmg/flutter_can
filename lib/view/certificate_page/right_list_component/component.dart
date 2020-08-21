import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class RightListComponent extends Component<RightListState> {
  RightListComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<RightListState>(
              adapter: null, slots: <String, Dependent<RightListState>>{}),
        );
}

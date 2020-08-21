import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LeftListComponent extends Component<LeftListState> {
  LeftListComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<LeftListState>(
              adapter: null, slots: <String, Dependent<LeftListState>>{}),
        );
}

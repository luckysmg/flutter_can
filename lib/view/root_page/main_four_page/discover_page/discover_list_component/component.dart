import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DiscoverListComponent extends Component<DiscoverListState> {
  DiscoverListComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DiscoverListState>(
              adapter: null, slots: <String, Dependent<DiscoverListState>>{}),
        );
}

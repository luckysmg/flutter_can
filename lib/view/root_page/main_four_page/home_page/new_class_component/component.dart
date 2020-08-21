import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class NewClassComponent extends Component<NewClassState> {
  NewClassComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<NewClassState>(
              adapter: null, slots: <String, Dependent<NewClassState>>{}),
        );
}

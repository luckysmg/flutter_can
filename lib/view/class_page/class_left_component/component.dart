import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ClassLeftComponent extends Component<ClassLeftState> {
  ClassLeftComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ClassLeftState>(
              adapter: null, slots: <String, Dependent<ClassLeftState>>{}),
        );
}

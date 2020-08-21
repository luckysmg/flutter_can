import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ClassRightComponent extends Component<ClassRightState> {
  ClassRightComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ClassRightState>(
              adapter: null, slots: <String, Dependent<ClassRightState>>{}),
        );
}

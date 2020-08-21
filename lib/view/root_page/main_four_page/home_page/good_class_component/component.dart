import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'view.dart';

class GoodClassComponent extends Component<HomeState> {
  GoodClassComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<HomeState>(
              adapter: null, slots: <String, Dependent<HomeState>>{}),
        );
}

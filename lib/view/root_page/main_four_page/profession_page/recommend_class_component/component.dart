import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'view.dart';

class RecommendClassComponent extends Component<ProfessionState> {
  RecommendClassComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<ProfessionState>(
              adapter: null, slots: <String, Dependent<ProfessionState>>{}),
        );
}

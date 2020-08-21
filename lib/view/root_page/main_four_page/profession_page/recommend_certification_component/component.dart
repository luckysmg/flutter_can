import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'view.dart';

class RecommendCertificationComponent extends Component<ProfessionState> {
  RecommendCertificationComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<ProfessionState>(
              adapter: null, slots: <String, Dependent<ProfessionState>>{}),
        );
}

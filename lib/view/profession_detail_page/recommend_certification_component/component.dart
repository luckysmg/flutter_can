import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'view.dart';

class RecommendCertificationComponent extends Component<ProfessionDetailState> {
  RecommendCertificationComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<ProfessionDetailState>(
              adapter: null,
              slots: <String, Dependent<ProfessionDetailState>>{}),
        );
}

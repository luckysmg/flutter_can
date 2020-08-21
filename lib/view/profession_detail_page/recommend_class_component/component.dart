import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'view.dart';

class RecommendClassComponent extends Component<ProfessionDetailState> {
  RecommendClassComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<ProfessionDetailState>(
              adapter: null,
              slots: <String, Dependent<ProfessionDetailState>>{}),
        );
}

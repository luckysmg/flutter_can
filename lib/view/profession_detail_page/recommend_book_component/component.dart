import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'view.dart';

class RecommendBookComponent extends Component<ProfessionDetailState> {
  RecommendBookComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<ProfessionDetailState>(
              adapter: null,
              slots: <String, Dependent<ProfessionDetailState>>{}),
        );
}

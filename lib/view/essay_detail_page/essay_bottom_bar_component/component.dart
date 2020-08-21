import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'view.dart';

class EssayBottomBarComponent extends Component<EssayDetailState> {
  EssayBottomBarComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<EssayDetailState>(
              adapter: null, slots: <String, Dependent<EssayDetailState>>{}),
        );
}

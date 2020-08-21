import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'view.dart';

class ListComponent extends Component<GalaxyDetailState> {
  ListComponent()
      : super(
          view: buildView,
        );
}

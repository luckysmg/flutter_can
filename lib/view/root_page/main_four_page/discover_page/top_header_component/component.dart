import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:发现的头部控件
///
class TopHeaderComponent extends Component<DiscoverState> {
  TopHeaderComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<DiscoverState>(
              adapter: null, slots: <String, Dependent<DiscoverState>>{}),
        );
}

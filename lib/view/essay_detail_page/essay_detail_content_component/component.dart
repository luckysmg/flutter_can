import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:内容布局（除了评论之外的部分）
///
class EssayDetailContentComponent extends Component<EssayDetailState> {
  EssayDetailContentComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<EssayDetailState>(
              adapter: null, slots: <String, Dependent<EssayDetailState>>{}),
        );
}

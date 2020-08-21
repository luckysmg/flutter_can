import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'view.dart';

///
/// @created by 文景睿
/// description:动态详情页面的两个Button(点赞和收藏）
///
class EssayDetailButtonsComponent extends Component<EssayDetailState> {
  EssayDetailButtonsComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<EssayDetailState>(
              adapter: null, slots: <String, Dependent<EssayDetailState>>{}),
        );
}

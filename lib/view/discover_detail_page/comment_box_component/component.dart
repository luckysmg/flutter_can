import 'package:fish_redux/fish_redux.dart';
import 'package:neng/view/discover_detail_page/comment_box_component/effect.dart';
import 'package:neng/view/discover_detail_page/comment_box_component/reducer.dart';

import 'state.dart';
import 'view.dart';

class CommentBoxComponent extends Component<CommentBoxState> {
  CommentBoxComponent()
      : super(
          view: buildView,
          effect: buildEffect(),
          reducer: buildReducer(),
          dependencies: Dependencies<CommentBoxState>(
              adapter: null, slots: <String, Dependent<CommentBoxState>>{}),
        );
}

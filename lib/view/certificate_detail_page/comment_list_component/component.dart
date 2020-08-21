import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class CommentListComponent extends Component<CommentListState> {
  CommentListComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<CommentListState>(
              adapter: null, slots: <String, Dependent<CommentListState>>{}),
        );
}

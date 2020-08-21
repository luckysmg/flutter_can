import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class BookDetailCommentListComponent
    extends Component<BookDetailCommentListState> {
  BookDetailCommentListComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<BookDetailCommentListState>(
              adapter: null,
              slots: <String, Dependent<BookDetailCommentListState>>{}),
        );
}

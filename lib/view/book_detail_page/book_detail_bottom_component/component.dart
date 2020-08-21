import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class BookDetailBottomComponent extends Component<BookDetailBottomState> {
  BookDetailBottomComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<BookDetailBottomState>(
              adapter: null,
              slots: <String, Dependent<BookDetailBottomState>>{}),
        );
}

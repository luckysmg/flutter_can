import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'view.dart';

class BookHeaderComponent extends Component<BookDetailState> {
  BookHeaderComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<BookDetailState>(
              adapter: null, slots: <String, Dependent<BookDetailState>>{}),
        );
}

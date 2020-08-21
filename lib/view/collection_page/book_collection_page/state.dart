import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/base_state.dart';

class BookCollectionState
    with BaseState
    implements Cloneable<BookCollectionState> {
  @override
  BookCollectionState clone() {
    return BookCollectionState()..hasNetworkError = hasNetworkError;
  }
}

BookCollectionState initState(Map<String, dynamic> args) {
  return BookCollectionState();
}

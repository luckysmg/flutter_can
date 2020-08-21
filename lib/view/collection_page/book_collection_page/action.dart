import 'package:fish_redux/fish_redux.dart';

enum BookCollectionAction { action }

class BookCollectionActionCreator {
  static Action onAction() {
    return const Action(BookCollectionAction.action);
  }
}

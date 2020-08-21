import 'package:fish_redux/fish_redux.dart';

enum BookDetailIntroductionAction { action }

class BookDetailIntroductionActionCreator {
  static Action onAction() {
    return const Action(BookDetailIntroductionAction.action);
  }
}

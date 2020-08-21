import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<BookDetailIntroductionState> buildEffect() {
  return combineEffects(<Object, Effect<BookDetailIntroductionState>>{
    BookDetailIntroductionAction.action: _onAction,
  });
}

void _onAction(Action action, Context<BookDetailIntroductionState> ctx) {}

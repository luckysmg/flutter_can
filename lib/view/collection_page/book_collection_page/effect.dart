import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<BookCollectionState> buildEffect() {
  return combineEffects(<Object, Effect<BookCollectionState>>{
    BookCollectionAction.action: _onAction,
  });
}

void _onAction(Action action, Context<BookCollectionState> ctx) {}

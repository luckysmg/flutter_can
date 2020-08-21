import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<NewClassState> buildEffect() {
  return combineEffects(<Object, Effect<NewClassState>>{
    NewClassAction.action: _onAction,
  });
}

void _onAction(Action action, Context<NewClassState> ctx) {}

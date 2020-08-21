import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ClassRightState> buildEffect() {
  return combineEffects(<Object, Effect<ClassRightState>>{
    ClassRightAction.switchIndex: _switchIndex,
  });
}

void _switchIndex(Action action, Context<ClassRightState> ctx) {
  ctx.state.scrollController.jumpTo(0);
}

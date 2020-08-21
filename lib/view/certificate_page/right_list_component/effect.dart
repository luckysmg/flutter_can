import 'package:fish_redux/fish_redux.dart';
import 'package:neng/view/certificate_page/right_list_component/action.dart';

import 'state.dart';

Effect<RightListState> buildEffect() {
  return combineEffects(<Object, Effect<RightListState>>{
    RightListAction.switchIndex: _switchIndex,
  });
}

void _switchIndex(Action action, Context<RightListState> ctx) {
  ctx.state.scrollController.jumpTo(0);
}

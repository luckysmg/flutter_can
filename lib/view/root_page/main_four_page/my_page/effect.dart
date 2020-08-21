import 'package:fish_redux/fish_redux.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/store/global_store.dart';

import 'action.dart';
import 'state.dart';

Effect<MyState> buildEffect() {
  return combineEffects(<Object, Effect<MyState>>{
    Lifecycle.initState: _onInit,
  });
}

void _onInit(Action action, Context<MyState> ctx) {
  GlobalStore.getEventBus().on<UserInfoChangeEvent>().listen((_) {
    ctx.dispatch(MyActionCreator.updateUI());
  });
}

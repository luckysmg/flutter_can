import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<ClassDetailState> buildEffect() {
  return combineEffects(<Object, Effect<ClassDetailState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    ClassDetailAction.updateUrl: _updateUrl,
  });
}

void _init(Action action, Context<ClassDetailState> ctx) async {}

void _dispose(Action action, Context<ClassDetailState> ctx) {
  ctx.state.player.release();
}

void _updateUrl(Action action, Context<ClassDetailState> ctx) async {
  await ctx.state.player.reset();
  final url = action.payload;
  await ctx.state.player.setDataSource(url, autoPlay: true);
  ctx.forceUpdate();
}

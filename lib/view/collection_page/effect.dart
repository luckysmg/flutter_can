import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';
import 'package:flutter/material.dart' hide Action;

Effect<CollectionState> buildEffect() {
  return combineEffects(<Object, Effect<CollectionState>>{
    CollectionAction.action: _onAction,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<CollectionState> ctx) {}

void _onInit(Action action, Context<CollectionState> ctx) {
  TickerProvider ticker = ctx.stfState as TickerProvider;
  final TabController tabController = TabController(length: 4, vsync: ticker);
  ctx.dispatch(CollectionActionCreator.init(tabController));
}

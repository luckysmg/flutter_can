import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

enum CollectionAction {
  action,
  init,
}

class CollectionActionCreator {
  static Action onAction() {
    return const Action(CollectionAction.action);
  }

  static Action init(TabController controller) {
    return Action(CollectionAction.init, payload: controller);
  }
}

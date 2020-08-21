import 'package:fish_redux/fish_redux.dart';

enum MyAction { updateUI }

class MyActionCreator {
  static Action updateUI() {
    return const Action(MyAction.updateUI);
  }
}

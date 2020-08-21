import 'package:fish_redux/fish_redux.dart';
import 'package:neng/view/root_page/main_four_page/my_page/header_component/state.dart';

class MyState implements Cloneable<MyState> {
  @override
  MyState clone() {
    return MyState();
  }
}

MyState initState(Map<String, dynamic> args) {
  return MyState();
}

///用户头像的名字那一块组件conn
class HeaderConnector extends ConnOp<MyState, HeaderState> {
  @override
  HeaderState get(MyState state) {
    final HeaderState subState = HeaderState();
    return subState;
  }

  @override
  void set(MyState state, HeaderState subState) {}
}

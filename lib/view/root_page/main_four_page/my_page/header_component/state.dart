import 'package:fish_redux/fish_redux.dart';

class HeaderState implements Cloneable<HeaderState> {
  @override
  HeaderState clone() {
    return HeaderState();
  }
}

HeaderState initState(Map<String, dynamic> args) {
  return HeaderState();
}

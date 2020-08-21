import 'package:fish_redux/fish_redux.dart';
import 'package:neng/redux/base_state.dart';

class EditInfoState with BaseState implements Cloneable<EditInfoState> {
  @override
  EditInfoState clone() {
    return EditInfoState()..hasNetworkError = hasNetworkError;
  }
}

EditInfoState initState(Map<String, dynamic> args) {
  return EditInfoState();
}

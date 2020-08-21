import 'package:fish_redux/fish_redux.dart';

enum LoginAction {
  updateUI,
  requestLogin,
  requestUserProfileInfo,
}

class LoginActionCreator {
  static Action updateUI(Map map) {
    return Action(LoginAction.updateUI, payload: map);
  }

  static Action requestLogin() {
    return Action(LoginAction.requestLogin);
  }

  static Action requestUserProfileInfo() {
    return Action(LoginAction.requestUserProfileInfo);
  }
}

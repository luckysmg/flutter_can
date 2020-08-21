import 'package:fish_redux/fish_redux.dart';

enum EditInfoAction { updateUI, selectHeadImg }

class EditInfoActionCreator {
  static Action updateUI() {
    return const Action(EditInfoAction.updateUI);
  }

  static Action selectHeadImg(bool useCamera) {
    return Action(EditInfoAction.selectHeadImg, payload: useCamera);
  }
}

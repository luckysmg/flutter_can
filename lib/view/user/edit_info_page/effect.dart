import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/user/edit_info_page/cut_image_page/page.dart';

import 'action.dart';
import 'state.dart';

Effect<EditInfoState> buildEffect() {
  return combineEffects(<Object, Effect<EditInfoState>>{
    Lifecycle.initState: _init,
    EditInfoAction.selectHeadImg: _selectHeadImg,
  });
}

void _init(Action action, Context<EditInfoState> ctx) {
  GlobalStore.getEventBus().on<UserInfoChangeEvent>().listen((_) {
    ctx.dispatch(EditInfoActionCreator.updateUI());
  });
}

void _selectHeadImg(Action action, Context<EditInfoState> ctx) async {
  var useCamera = action.payload;
  File file = await ImagePicker.pickImage(
      source: useCamera ? ImageSource.camera : ImageSource.gallery);

  if (file != null) {
    NavigatorUtil.push(
        ctx.context,
        CutImagePage(
          file: file,
        ));
  }
}

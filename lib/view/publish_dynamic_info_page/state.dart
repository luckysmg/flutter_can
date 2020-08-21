import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:neng/redux/base_state.dart';

class PublishDynamicInfoState
    with BaseState
    implements Cloneable<PublishDynamicInfoState> {
  TextEditingController textEditingController;
  FocusNode focusNode;
  List<Asset> selectedPhotoList;

  ///行星oid
  String oid;

  @override
  PublishDynamicInfoState clone() {
    return PublishDynamicInfoState()
      ..hasNetworkError = hasNetworkError
      ..textEditingController = textEditingController
      ..focusNode = focusNode
      ..selectedPhotoList = selectedPhotoList
      ..oid = oid;
  }
}

PublishDynamicInfoState initState(Map<String, dynamic> args) {
  return PublishDynamicInfoState()
    ..oid = args['oid']
    ..textEditingController = TextEditingController()
    ..focusNode = FocusNode()
    ..selectedPhotoList = List.of([], growable: true);
}

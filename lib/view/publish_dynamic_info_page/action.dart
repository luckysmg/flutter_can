import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

enum PublishDynamicInfoAction {
  getPhotos,
  deletePhoto,
  publish,
  uploadImage,
  publishAfterUploadingImg
}

class PublishDynamicInfoActionCreator {
  static Action getPhotos() {
    return const Action(PublishDynamicInfoAction.getPhotos);
  }

  static Action deletePhoto(Asset asset) {
    return Action(PublishDynamicInfoAction.deletePhoto, payload: asset);
  }

  static Action publish() {
    return Action(PublishDynamicInfoAction.publish);
  }

  static Action uploadImage(List<MultipartFile> fileList) {
    return Action(PublishDynamicInfoAction.uploadImage, payload: fileList);
  }

  static Action publishAfterUploadingImg(List<String> imgUrlList) {
    return Action(PublishDynamicInfoAction.publishAfterUploadingImg,
        payload: imgUrlList);
  }
}

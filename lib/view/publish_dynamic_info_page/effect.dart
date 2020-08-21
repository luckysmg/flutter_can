import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/entity/up_load_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/dialog_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/view/planet_info_page/planet_all_dynamic_info_page/action.dart';
import 'package:neng/view/publish_dynamic_info_page/action.dart';

import 'state.dart';

Effect<PublishDynamicInfoState> buildEffect() {
  return combineEffects(<Object, Effect<PublishDynamicInfoState>>{
    Lifecycle.dispose: _dispose,
    PublishDynamicInfoAction.getPhotos: _getPhotos,
    PublishDynamicInfoAction.deletePhoto: _deletePhoto,
    PublishDynamicInfoAction.publish: _publish,
    PublishDynamicInfoAction.uploadImage: _uploadImage,
    PublishDynamicInfoAction.publishAfterUploadingImg:
        _publishAfterUploadingImg,
  });
}

void _publish(Action action, Context<PublishDynamicInfoState> ctx) async {
  String textContent = ctx.state.textEditingController.text;
  if (textContent == null || textContent.length == 0) {
    ToastUtil.show("请输入文字内容");
    return;
  }

  if (ctx.state.selectedPhotoList.length == 0) {
    ///如果没有图片，那么不用上传文件，直接请求接口传文字即可
    DioUtil.getInstance().doPost<SimpleEntity>(
        url: API.essay_add,
        context: ctx.context,
        param: {'communityOid': ctx.state.oid, 'content': textContent},
        onSuccess: (data) {
          Navigator.pop(ctx.context);
          ctx.broadcast(PlanetAllDynamicInfoActionCreator.reload());
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  } else {
    ///如果有图片,那就拿到已经选择的图片进行操作
    DialogUtil.showLoadingDialog(context: ctx.context);
    List<MultipartFile> fileList = [];
    List<Asset> photoList = ctx.state.selectedPhotoList;
    for (int i = 0; i < photoList.length; i++) {
      ByteData byteData = await photoList[i].requestOriginal();

      ///将每个照片读取原数组
      List<int> dataBytesList = await byteData.buffer.asUint8List();

      ///压缩
      var compressResult = await FlutterImageCompress.compressWithList(
          dataBytesList,
          quality: 20,
          format: CompressFormat.jpeg);

      ///压缩后添加到MultipartFile集合中
      MultipartFile multipartFile = MultipartFile.fromBytes(compressResult);
      fileList.add(multipartFile);

      ///最后一个压缩完，准备上传图片
      if (i == photoList.length - 1) {
        ctx.dispatch(PublishDynamicInfoActionCreator.uploadImage(fileList));
      }
    }
  }
}

void _uploadImage(Action action, Context<PublishDynamicInfoState> ctx) {
  ///图片的文件集合
  List<MultipartFile> fileList = action.payload;
  Map<String, dynamic> map = new Map();
  map["storage"] = "OSS";

  for (int i = 0; i < fileList.length; i++) {
    map["files_" + i.toString() + ".jpeg"] = fileList[i];
  }
  var formData = FormData.fromMap(map);
  DioUtil.getInstance().doPost<UpLoadEntity>(
      url: API.uploadFile,
      context: ctx.context,
      param: formData,
      onSuccess: (data) {
        ///先获取图片url集合
        List<String> imgUrlList = List();
        data.files.forEach((item) {
          imgUrlList.add(item.url);
        });

        ///上传完毕后请求发布动态的接口
        ctx.dispatch(PublishDynamicInfoActionCreator.publishAfterUploadingImg(
            imgUrlList));
      },
      onFailure: (e) {
        DialogUtil.closeLoadingDialog(ctx.context);
        ToastUtil.show(e.msg);
      });
}

void _publishAfterUploadingImg(
    Action action, Context<PublishDynamicInfoState> ctx) {
  ///图片url集合
  List<String> imgUrlList = action.payload;
  Map param = _getParam(imgUrlList, ctx);
  DioUtil.getInstance().doPost<SimpleEntity>(
      url: API.essay_add,
      context: ctx.context,
      param: param,
      onSuccess: (data) {
        DialogUtil.closeLoadingDialog(ctx.context);
        ctx.broadcast(PlanetAllDynamicInfoActionCreator.reload());
        Navigator.pop(ctx.context);
      },
      onFailure: (e) {
        DialogUtil.closeLoadingDialog(ctx.context);
        ToastUtil.show(e.msg);
      });
}

Map _getParam(List<String> imgUrlList, Context<PublishDynamicInfoState> ctx) {
  Map param = {
    'communityOid': ctx.state.oid,
    'content': ctx.state.textEditingController.text,
  };

  for (int i = 0; i < imgUrlList.length; i++) {
    switch (i) {
      case 0:
        param.addAll({'imgOne': imgUrlList[i]});
        break;
      case 1:
        param.addAll({'imgTwo': imgUrlList[i]});
        break;
      case 2:
        param.addAll({'imgThree': imgUrlList[i]});
        break;
      case 3:
        param.addAll({'imgFour': imgUrlList[i]});
        break;
      case 4:
        param.addAll({'imgFive': imgUrlList[i]});
        break;
      case 5:
        param.addAll({'imgSix': imgUrlList[i]});
        break;
      case 6:
        param.addAll({'imgSeven': imgUrlList[i]});
        break;
      case 7:
        param.addAll({'imgEight': imgUrlList[i]});
        break;
      case 8:
        param.addAll({'imgNine': imgUrlList[i]});
        break;
    }
  }
  return param;
}

void _getPhotos(Action action, Context<PublishDynamicInfoState> ctx) async {
  ///如果有选择图片，那么做以下操作，如果没有选择则什么都不干
  //ctx.state.selectedPhotoList.addAll(photoEntityList);
  ctx.forceUpdate();
}

void _deletePhoto(Action action, Context<PublishDynamicInfoState> ctx) {
  Asset asset = action.payload;
  ctx.state.selectedPhotoList.remove(asset);
  ctx.forceUpdate();
}

void _dispose(Action action, Context<PublishDynamicInfoState> ctx) {
  ctx.state.focusNode.unfocus();
}

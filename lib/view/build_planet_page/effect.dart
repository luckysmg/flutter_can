import 'dart:io';
import 'dart:typed_data';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:image_picker/image_picker.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/entity/up_load_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/compress_image_util.dart';
import 'package:neng/util/form_data_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/view/knowledge_page/action.dart';

import 'action.dart';
import 'state.dart';

File file;
Effect<BuildPlanetState> buildEffect() {
  return combineEffects(<Object, Effect<BuildPlanetState>>{
    BuildPlanetAction.selectImg: _selectImg,
    BuildPlanetAction.addPlanet: _addPlanet
  });
}

void _selectImg(Action action, Context<BuildPlanetState> ctx) async {
  var useCamera = action.payload;
  file = await ImagePicker.pickImage(
      source: useCamera ? ImageSource.camera : ImageSource.gallery);

  ///如果没有选择图片，直接返回
  if (file == null) {
    return;
  }

  ///否则更新界面
  Uint8List data = await file.readAsBytes();
  ctx.state.img = data;
  ctx.forceUpdate();
}

void _addPlanet(Action action, Context<BuildPlanetState> ctx) async {
  String title = ctx.state.textEditingController.text;
  if (title.isEmpty) {
    TipUtil.showWaring(context: ctx.context, message: '请输入名称');
    return;
  }
  Uint8List img = ctx.state.img;
  if (img == null) {
    ///如果没有选择图片那么直接请求添加行星的接口,成功后跳转到知识行星列表页并且刷新列表页
    DioUtil.getInstance().doPost<SimpleEntity>(
        url: API.galaxy_add,
        context: ctx.context,
        param: {
          'title': title,
          'img': "NONE",
        },
        onSuccess: (data) {
          ///返回列表并且刷新知识行星的页面
          ctx.broadcast(KnowledgeActionCreator.reload());
          Navigator.pop(ctx.context);
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  } else {
    ///如果选择了图片，那么上传图片操作
    var compressImgData = await CompressImageUtil.getCompressImage(img);
    //获取文件名称
    var name =
        file.path.substring(file.path.lastIndexOf("/") + 1, file.path.length);

    var formData = FormDataUtil.parseSingleImageFormData(compressImgData, name);

    DioUtil.getInstance().doPost<UpLoadEntity>(
        url: API.uploadFile,
        context: ctx.context,
        param: formData,
        onSuccess: (data) {
          String imgUrl = data.files[0].url;
          requestAdd(imgUrl, ctx);
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }
}

void requestAdd(String imgUrl, Context<BuildPlanetState> ctx) {
  DioUtil.getInstance().doPost<SimpleEntity>(
      url: API.galaxy_add,
      context: ctx.context,
      param: {
        'title': ctx.state.textEditingController.text,
        'img': imgUrl,
      },
      onSuccess: (data) {
        ctx.broadcast(KnowledgeActionCreator.reload());
        Navigator.pop(ctx.context);
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

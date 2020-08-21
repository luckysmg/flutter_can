import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neng/entity/planet_detail_entity.dart';
import 'package:neng/entity/up_load_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/compress_image_util.dart';
import 'package:neng/util/dialog_util.dart';
import 'package:neng/util/form_data_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';

import 'action.dart';
import 'state.dart';

Effect<PlanetDetailState> buildEffect() {
  return combineEffects(<Object, Effect<PlanetDetailState>>{
    Lifecycle.initState: _init,
    PlanetDetailAction.selectImg: _selectImg,
  });
}

void _init(Action action, Context<PlanetDetailState> ctx) {
  DioUtil.getInstance().doPost<PlanetDetailEntity>(
      url: '${API.planet_detail}/${ctx.state.oid}',
      context: ctx.context,
      needDelay: true,
      onSuccess: (data) {
        ctx.state.planetDetailEntity = data;
        ctx.forceUpdate();
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

void _selectImg(Action action, Context<PlanetDetailState> ctx) async {
  try {
    var useCamera = action.payload;
    File file = await ImagePicker.pickImage(
        source: useCamera ? ImageSource.camera : ImageSource.gallery);
    var name =
        file.path.substring(file.path.lastIndexOf("/") + 1, file.path.length);
    if (file != null) {
      DialogUtil.showLoadingDialog(
          context: ctx.context, debugDismissible: true);

      var data = await file.readAsBytes();

      ///压缩
      var compressResult = await CompressImageUtil.getCompressImage(data);
      FormData formData =
          FormDataUtil.parseSingleImageFormData(compressResult, name);

      ///上传文件
      DioUtil.getInstance().doPost<UpLoadEntity>(
          url: API.uploadFile,
          context: ctx.context,
          param: formData,
          onSuccess: (data) {
            ///上传完成后请求修改图片接口
            requestChangeImg(data.files[0].url, ctx);
          },
          onFailure: (e) {
            ToastUtil.show(e.msg);
          });
    }
  } catch (e) {
    print(e.toString());
  }
}

void requestChangeImg(String url, Context<PlanetDetailState> ctx) {
  DioUtil.getInstance().doPost(
      url: API.change_planet_img,
      context: ctx.context,
      param: {'img': url, 'oid': ctx.state.oid},
      onSuccess: (data) {
        DialogUtil.closeLoadingDialog(ctx.context);
        ctx.dispatch(LifecycleCreator.initState());
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });
}

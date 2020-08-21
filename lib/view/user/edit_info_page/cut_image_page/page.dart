import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_editor/image_editor.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/entity/up_load_entity.dart';
import 'package:neng/entity/user_profile_entity.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/dialog_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/util/user_profile_util.dart';

///
/// @created by 文景睿
/// description：剪裁页面
///
class CutImagePage extends StatelessWidget {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  final File file;

  CutImagePage({Key key, this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ExtendedImage.file(
            file,
            fit: BoxFit.contain,
            mode: ExtendedImageMode.editor,
            extendedImageEditorKey: editorKey,
            initEditorConfigHandler: (state) {
              return EditorConfig(
                  eidtorMaskColorHandler: (ctx, s) {
                    return Colors.black54;
                  },
                  maxScale: 8.0,
                  cropRectPadding: EdgeInsets.all(20.0),
                  hitTestSize: 20.0,
                  cropAspectRatio: 1.0);
            },
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    var style =
        TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(30));
    return Positioned(
      bottom: 0,
      child: Container(
        height: 90,
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: ScreenUtil.screenWidthDp,
        color: Colors.black54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                '返回',
                style: style,
              ),
            ),
            GestureDetector(
                onTap: () => uploadImg(context),
                child: Text('完成', style: style)),
          ],
        ),
      ),
    );
  }

  ///上传图片
  void uploadImg(BuildContext context) async {
    DialogUtil.showLoadingDialog(context: context);
    Uint8List data = await cut(editorKey.currentState);
    List<int> result = await getCompressList(data);
    //获取文件名称
    var name =
        file.path.substring(file.path.lastIndexOf("/") + 1, file.path.length);
    var formData = FormData.fromMap(
        {"storage": "OSS", name: MultipartFile.fromBytes(result)});

    DioUtil.getInstance().doPost<UpLoadEntity>(
        url: API.uploadFile,
        context: context,
        param: formData,
        onSuccess: (data) async {
          requestSaveHeadImg(context, data.files[0].url);
        },
        onFailure: (e) {
          ToastUtil.show('上传错误');
          TipUtil.show(context: context, message: "上传错误");
          DialogUtil.closeLoadingDialog(context);
        });
  }

  ///保存图片请求
  void requestSaveHeadImg(BuildContext context, String url) {
    DioUtil.getInstance().doPost<SimpleEntity>(
        url: API.save_head,
        context: context,
        param: {'headImageUrl': url},
        onSuccess: (data) async {
          DialogUtil.closeLoadingDialog(context);
          UserProfileEntity entity = UserProfileUtil.getUserDetailInfo();
          entity.headImageUrl = url;
          await UserProfileUtil.setUserDetailInfo(entity);
          GlobalStore.getEventBus().fire(UserInfoChangeEvent());
          //TipUtil.show(context: context, message: '保存成功');
          Navigator.pop(context);
        },
        onFailure: (e) {
          DialogUtil.closeLoadingDialog(context);
          TipUtil.showWaring(context: context, message: e.msg);
        });
  }

  Future<List<int>> getCompressList(List<int> list) async {
    var result = await FlutterImageCompress.compressWithList(list,
        quality: 40, format: CompressFormat.jpeg);
    return result;
  }

  Future<List<int>> cut(ExtendedImageEditorState state) async {
    final cropRect = state.getCropRect();
    final action = state.editAction;
    final rotateAngle = action.rotateAngle.toInt();
    final flipHorizontal = action.flipY;
    final flipVertical = action.flipX;
    final img = state.rawImageData;
    ImageEditorOption option = ImageEditorOption();
    option.addOption(ClipOption.fromRect(cropRect));
    option.addOption(
        FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
    option.addOption(RotateOption(rotateAngle));
    final result = await ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );
    return result;
  }
}

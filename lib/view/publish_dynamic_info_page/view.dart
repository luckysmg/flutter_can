import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/view/publish_dynamic_info_page/action.dart';
import 'package:neng/widgets/network_error_view.dart';

import 'state.dart';

Widget buildView(
    PublishDynamicInfoState state, Dispatch dispatch, ViewService viewService) {
  ///navBar左上角的退出按钮
  var navLeadingView = const Text('取消')
      .withStyle(fontSize: Constants.mainTextSize)
      .paddingTop(12)
      .onTap(() => Navigator.pop(viewService.context));

  ///navBar右上角的发布按钮
  var navTrailingView = CupertinoButton(
    borderRadius: BorderRadius.circular(2),
    color: ColorUtil.mainColor,
    minSize: 0,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Text('发布').withStyle(
        fontSize: Constants.mainTextSize, color: ColorUtil.darkBackTextColor),
    onPressed: () => dispatch(PublishDynamicInfoActionCreator.publish()),
  );
  var body;

  if (state.hasNetworkError) {
    ///网络错误布局
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else {
    ///内容布局
    body = EasyRefresh(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          _buildInputBox(state, dispatch, viewService),
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemCount: state.selectedPhotoList.length == 3
                  ? state.selectedPhotoList.length
                  : state.selectedPhotoList.length + 1,
              itemBuilder: (context, index) {
                if (index == state.selectedPhotoList.length &&
                    state.selectedPhotoList.length != 3) {
                  return _buildExtraItem(state, dispatch, viewService);
                } else {
                  return _photoItem(state, dispatch, context, index);
                }
              }),
        ],
      ),
    );
  }

  return GestureDetector(
    onTap: () {
      state.focusNode.unfocus();
    },
    child: Scaffold(
      appBar: CupertinoNavigationBar(
        leading: navLeadingView,
        trailing: navTrailingView,
      ),
      body: body,
    ),
  );
}

///输入框布局
Widget _buildInputBox(
    PublishDynamicInfoState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 16),
    height: 200,
    decoration: BoxDecoration(
        color: ColorUtil.auxiliaryColor,
        borderRadius: BorderRadius.circular(4)),
    child: TextField(
      style: TextStyle(fontSize: Constants.mainTextSize),

      ///null代表自动换行
      maxLines: null,
      focusNode: state.focusNode,
      controller: state.textEditingController,
      decoration: InputDecoration(
          hintText: '说点什么...',
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
    ),
  );
}

Widget _photoItem(PublishDynamicInfoState state, Dispatch dispatch,
    BuildContext context, int index) {
  return FittedBox(
    fit: BoxFit.cover,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          child: AssetThumb(
            asset: state.selectedPhotoList[index],
            width: 100,
            height: 100,
          ),
        ),
        Icon(
          Icons.cancel,
          color: ColorUtil.secondaryColor,
          size: 30,
        ).onTap(() {
          dispatch(PublishDynamicInfoActionCreator.deletePhoto(
              state.selectedPhotoList[index]));
        }).offset(offset: Offset(30, -30)),
      ],
    ),
  );
}

///构建这个额外的item来返回一个点击添加照片的布局
Widget _buildExtraItem(state, Dispatch dispatch, ViewService viewService) {
  return CupertinoButton(
    padding: const EdgeInsets.only(),
    borderRadius: BorderRadius.circular(4),
    pressedOpacity: 0.6,
    color: ColorUtil.auxiliaryColor,
    child: Icon(
      Icons.add,
      color: ColorUtil.secondaryColor,
      size: 40,
    ),
    onPressed: () {
      ///获取照片
      _getPhotos(state, dispatch);
    },
  );
}

Future<void> _getPhotos(
    PublishDynamicInfoState state, Dispatch dispatch) async {
  state.selectedPhotoList = await MultiImagePicker.pickImages(
    maxImages: 3,
    enableCamera: false,
    selectedAssets: state.selectedPhotoList,
    cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
    materialOptions: MaterialOptions(
      actionBarColor: "#3D58EF",
      actionBarTitle: "选择图片",
      allViewTitle:"所有图片",
      selectCircleStrokeColor: "#000000",
    ),
  );
  dispatch(PublishDynamicInfoActionCreator.getPhotos());
}

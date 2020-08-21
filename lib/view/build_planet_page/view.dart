import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/view/build_planet_page/action.dart';
import 'package:neng/view/login/widgets/login_button.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/load_asset_image.dart';

import 'state.dart';

Widget buildView(
    BuildPlanetState state, Dispatch dispatch, ViewService viewService) {
  var body;

  body = EasyRefresh(
    child: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        Gap.makeGap(height: 20),
        Container(
          child: state.img == null
              ? LoadAssetImage(
                  'default/pic_blank_planet',
                  height: 200,
                  fit: BoxFit.cover,
                )
              : Image.memory(
                  state.img,
                  fit: BoxFit.cover,
                ),
          height: 200,
          //color: Colors.redAccent,
        ).onTap(() {
          _showSheet(viewService.context, dispatch);
        }),
        Gap.makeGap(height: 20),
        _buildTextField(state, dispatch, viewService),
        Gap.makeGap(height: 20),
        LoginButton(
          onTap: () => dispatch(BuildPlanetActionCreator.addPlanet()),
        ).center()
      ],
    ),
  );

  return GestureDetector(
    onTap: () {
      state.focusNode.unfocus();
    },
    child: Scaffold(
      appBar: CustomNavigationBar(
        title: '构建星球',
      ),
      body: body,
    ),
  );
}

Widget _buildTextField(
    BuildPlanetState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: TextField(
      focusNode: state.focusNode,
      controller: state.textEditingController,
      style: TextStyle(fontSize: Constants.inputTextSize),
      textAlign: TextAlign.center,
      inputFormatters: [
        BlacklistingTextInputFormatter(RegExp("[' ']")),
        WhitelistingTextInputFormatter(
            RegExp("[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]")),
        LengthLimitingTextInputFormatter(16),
      ],
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    ).backgroundColor(ColorUtil.auxiliaryColor).cornerRadius(4),
  );
}

void _showSheet(BuildContext context, Dispatch dispatch) async {
  var useCamera;
  useCamera = await showModalBottomSheet<bool>(
      context: context,
      builder: (ctx) {
        var cameraItemView = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context, true);
          },
          child: Container(
            color: ColorUtil.whiteColor,
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                '拍照',
                style: TextStyle(
                  fontSize: Constants.mainTextSize,
                  color: ColorUtil.mainTextColor,
                ),
              ),
            ),
          ),
        );

        var imgItemView = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context, false);
          },
          child: Container(
            color: ColorUtil.whiteColor,
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                '相册',
                style: TextStyle(
                  fontSize: Constants.mainTextSize,
                  color: ColorUtil.mainTextColor,
                ),
              ),
            ),
          ),
        );

        return Container(
          color: ColorUtil.auxiliaryColor,
          height: Platform.isAndroid ? 150 : 180,
          child: Column(
            children: <Widget>[
              cameraItemView,
              Gap.line(),
              imgItemView,
              Gap.line(),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: Platform.isAndroid ? 50 : 80,
                    alignment: Alignment.center,
                    margin:
                    EdgeInsets.only(bottom: Platform.isAndroid ? 0 : 30),
                    width: double.infinity,
                    child: Text('取消',
                        style: TextStyle(
                            color: ColorUtil.mainTextColor,
                            fontSize: Constants.mainTextSize)),
                  ),
                ),
              )
            ],
          ),
        );
      });

  if (useCamera == null) {
    return;
  }
  dispatch(BuildPlanetActionCreator.selectImg(useCamera));
}

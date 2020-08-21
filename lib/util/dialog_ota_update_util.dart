import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/progress_dialog.dart';

import 'color_util.dart';
import 'constants.dart';

class DialogOtaUpdateUtil {
  DialogOtaUpdateUtil._();

  static void showDialog(
      {@required BuildContext context,
      @required String title,
      String confirmText = "后台下载",
      String cancelText = "稍后安装",
      double dialogHeight = 150,
      VoidCallback onConfirm,
      VoidCallback onCancel}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              child: Container(
                height: dialogHeight,
                width: ScreenUtil.screenWidthDp * 0.72,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: LoadAssetImage(
                          "update_head",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    ///下面的按钮
                    Container(
                      //height: ScreenUtil().setHeight(90),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: ColorUtil.auxiliaryColor, width: 0.6),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CupertinoButton(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(25),
                                horizontal: ScreenUtil().setWidth(70)),
                            minSize: ScreenUtil().setHeight(25),
                            pressedOpacity: 0.4,
                            child: Text(cancelText,
                                style: TextStyle(
                                    color: ColorUtil.secondaryTextColor,
                                    fontSize: Constants.mainTextSize)),
                            onPressed: onCancel ??
                                () {
                                  Navigator.pop(context);
                                },
                          ),
                          Gap.vLine,
                          CupertinoButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: ScreenUtil().setHeight(25),
                                  horizontal: ScreenUtil().setWidth(70)),
                              minSize: ScreenUtil().setHeight(25),
                              pressedOpacity: 0.4,
                              child: Text(confirmText,
                                  style: TextStyle(
                                      color: ColorUtil.mainColor,
                                      fontSize: Constants.mainTextSize)),
                              onPressed: onConfirm),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

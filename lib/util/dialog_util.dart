import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/widgets/progress_dialog.dart';

import 'color_util.dart';
import 'constants.dart';

class DialogUtil {
  DialogUtil._();

  static bool _isShow = false;

  static void closeLoadingDialog(BuildContext context) {
    if (_isShow) {
      Navigator.pop(context);
      _isShow = false;
    }
  }

  static void showDialog(
      {@required BuildContext context,
      @required String title,
      String confirmText = "确定",
      String cancelText = "取消",
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 26),
                      alignment: Alignment.center,
                      height: ScreenUtil().setHeight(150),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: ScreenUtil().setSp(32),
                            color: Colors.black),
                      ),
                    ),
                    const Spacer(),

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
                                horizontal: ScreenUtil().setWidth(100)),
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
                                  horizontal: ScreenUtil().setWidth(100)),
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

  static Future<T> showLoadingDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = false,
    bool debugDismissible = false,
    WidgetBuilder builder,
  }) {
    _isShow = true;
    final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(
          builder: (ctx) {
            return GestureDetector(
                onTap: () {
                  if (debugDismissible) Navigator.pop(context);
                },
                child: const ProgressDialog(hintText: "正在加载..."));
          },
        );
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: const Color(0x00FFFFFF),
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

  static Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}

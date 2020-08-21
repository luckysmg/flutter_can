import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neng/route/custom_routes.dart';

///
/// @created by 文景睿
/// description:导航跳转工具类
///
class NavigatorUtil {
  NavigatorUtil._();

  static Future push(BuildContext context, Widget destinationPage,
      {bool rootNavigator = false,
      bool fullScreenDialog = false,
      bool finishCurrentPage = false}) async {
    var result;

    if (fullScreenDialog && finishCurrentPage) {
      result = await Navigator.of(context, rootNavigator: rootNavigator)
          .pushReplacement(
        CupertinoPageRoute(
            builder: (BuildContext context) => destinationPage,
            fullscreenDialog: true),
      );
      return result;
    }

    if (fullScreenDialog) {
      result = await Navigator.of(context, rootNavigator: rootNavigator).push(
        CupertinoPageRoute(
            builder: (BuildContext context) => destinationPage,
            fullscreenDialog: true),
      );
    } else if (finishCurrentPage) {
      if (Platform.isAndroid) {
        result = await Navigator.of(context, rootNavigator: rootNavigator)
            .pushReplacement(
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      } else {
        result = await Navigator.of(context, rootNavigator: rootNavigator)
            .pushReplacement(
          CustomIOSRoute(builder: (context) => destinationPage),
        );
      }
    } else {
      if (Platform.isAndroid) {
        result = await Navigator.of(context, rootNavigator: rootNavigator).push(
            MaterialPageRoute(
                builder: (BuildContext context) => destinationPage));
      } else {
        result = await Navigator.of(context, rootNavigator: rootNavigator).push(
          CustomIOSRoute(builder: (BuildContext context) => destinationPage),
        );
      }
    }

    return result;
  }

  static popAndPush(BuildContext context) {}

  ///直接pop到首页
  static popToHome(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('root'));
  }

//  static void pushToImagePreviewPage(
//      BuildContext context, String url, BoxFit boxFit) {
//    Navigator.push(
//        context, ImagePreViewPageRoute(ImagePreviewPage(url, boxFit)));
//  }
}

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'constants.dart';

///
/// @created by 文景睿
/// description:Toast工具类
///
class ToastUtil {
  ToastUtil._();
  static show(String msg) {
    showToast(
      msg,
      duration: Duration(milliseconds: 1500),
      position: ToastPosition.bottom,
      radius: 2.0,
      textStyle: TextStyle(fontSize: Constants.secondTextSize),
    );
  }
}

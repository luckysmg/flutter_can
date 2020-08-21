import 'package:flutter/material.dart';

///
/// @created by 文景睿
/// description:颜色类
///
class ColorUtil {
  ColorUtil._();

  ///主题色
  static final Color mainColor = ColorUtil.hexToColor('#3D58EF');

  ///白色背景
  static final Color scaffoldColor = Colors.white;

  ///辅助色1(较深）按钮边框等
  static final Color secondaryColor = ColorUtil.hexToColor('#DADDE5');

  ///辅助色2较浅 分割线，底板等
  static final Color auxiliaryColor = ColorUtil.hexToColor('#F2F6F9');

  ///辅助色3，点赞按钮，红色
  static final Color redColor = ColorUtil.hexToColor("#FF3D5A");

  //辅助色4，白色
  static final Color whiteColor = ColorUtil.hexToColor("#FFFFFF");

  ///主要文字颜色
  static final Color mainTextColor = ColorUtil.hexToColor("#333333");

  ///链接文字色
  static final Color linkTextColor = ColorUtil.hexToColor('#3D58EF');

  ///次要文字颜色
  static final Color secondaryTextColor = ColorUtil.hexToColor("#666666");

  ///辅助文字颜色
  static final Color auxiliaryTextColor = ColorUtil.hexToColor("#999999");

  ///深色背景文字颜色
  static final Color darkBackTextColor = ColorUtil.hexToColor("#FFFFFF");

  //static final Color text_disabled = ColorUtil.hexToColor("#D4E2FA");
  //static final Color dark_text_disabled = ColorUtil.hexToColor("#CEDBF2");

  //个人中心修改资料按钮色
  static final Color disabledButtonColor = ColorUtil.hexToColor("#96BBFA");
  //static final Color dark_button_disabled = ColorUtil.hexToColor("#83A5E0");

  static Color hexToColor(String s) {
    // 如果传入的十六进制颜色值不符合要求，返回默认值
    if (s == null ||
        s.length != 7 ||
        int.tryParse(s.substring(1, 7), radix: 16) == null) {
      s = '#999999';
    }
    return Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
  }
}

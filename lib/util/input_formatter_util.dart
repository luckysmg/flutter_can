import 'package:flutter/services.dart';

///
/// @created by 文景睿
/// description:textField的限制输入输入配置
///
class InputFormatterUtil {
  ///如果需要多种要求混合的，直接把这些item里面取你需要的放入inputFormatter的参数数组就行

  ///only数字
  static TextInputFormatter onlyNumItem =
      WhitelistingTextInputFormatter(RegExp("[0-9]"));

  ///不能数字
  static TextInputFormatter noneNumItem =
      BlacklistingTextInputFormatter(RegExp("[0-9]"));

  ///不允许空格
  static TextInputFormatter noneSpaceItem =
      BlacklistingTextInputFormatter(RegExp("[' ']"));

  ///只能是字母
  static TextInputFormatter onlyWordItem =
      WhitelistingTextInputFormatter(RegExp("[a-zA-Z]"));

  ///只允许输入数字
  static List<TextInputFormatter> onlyNum = [
    onlyNumItem,
  ];

  ///不允许有空格
  static List<TextInputFormatter> noneSpace = [noneSpaceItem];

  ///只允许输入字母
  static List<TextInputFormatter> onlyWord = [onlyWordItem];

  ///不允许数字
  static List<TextInputFormatter> noneNum = [noneNumItem];
}

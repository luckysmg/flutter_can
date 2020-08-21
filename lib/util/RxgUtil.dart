///
/// @created by 文景睿
/// description:正则表达式工具
///
class RxgUtil {
  ///是否是电话号码
  static bool isChinaPhoneNum(String str) {
    return new RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
        .hasMatch(str);
  }
}

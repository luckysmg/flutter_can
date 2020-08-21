import 'package:connectivity/connectivity.dart';

///
/// @created by 文景睿
/// description:检测网络状态工具
///
class NetWorkUtil {
  NetWorkUtil._();
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<bool> isWifi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}

import 'package:event_bus/event_bus.dart';
import 'package:package_info/package_info.dart';

///
/// @created by 文景睿
/// description:全局数据存储
///
class GlobalStore {
  GlobalStore._();

  static PackageInfo packageInfo;

  ///登录页是否已经开启（防止重开登录页）
  static bool isShowingLoginPage = false;

  ///事件传递框架
  static EventBus _eventBus;

  static EventBus getEventBus() {
    if (_eventBus == null) {
      _eventBus = EventBus();
    }
    return _eventBus;
  }
}

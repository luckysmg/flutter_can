import 'package:connectivity/connectivity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:neng/util/tip_util.dart';

EffectMiddleware<T> networkErrorMiddleware<T>({String tag = 'redux'}) {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          ///如果是page并且 action是生命周期类型
          if (action.type == Lifecycle.initState) {
            ///如果现在是init周期，且网络错误状态，那么重置网络状态
            ///也就是显示loading页面
            if (ctx.state.hasNetworkError) {
              ctx.state.hasNetworkError = false;
              ctx.forceUpdate();
            }

            ///进行网络检查
            Connectivity().checkConnectivity().then((data) {
              if (data == ConnectivityResult.none) {
                ///没网
                ctx.state.hasNetworkError = true;
                ctx.forceUpdate();

                ///如果是网络错误，那么就不会回调正常的init事件，事件结束
                return null;
              } else {
                ///有网
                ctx.state.hasNetworkError = false;

                ///否则直接回调正常的effect
                return effect?.call(action, ctx);
              }
            });
          }
        } else {
          ///不是page，或者action类型不是生命周期事件，直接回调正常的effect
          return effect?.call(action, ctx);
        }

        return effect?.call(action, ctx);
      };
    };
  };
}

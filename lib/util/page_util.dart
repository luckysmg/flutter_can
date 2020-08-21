import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/net/error_handle.dart';
import 'package:neng/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///
/// @created by 文景睿
/// description:分页逻辑，加载逻辑封装
///
class PageUtil {
  PageUtil._();

  ///初始化加载失败，刷新失败的逻辑封装
  ///1.显示网络错误状态
  ///2.弹出提示
  static initFail(Context ctx, NetError e) {
    if (e.networkError) {
      ctx.state.hasNetworkError = true;
      ctx.forceUpdate();
    }
    ToastUtil.show(e.msg);
  }

  ///加载更多失败后调用
  static loadFailed({@required RefreshController controller}) {
    controller.loadFailed();
  }

  ///在网络数据返回后，在onSuccess回调中调用，更新刷新器
  static updateAfterInitOrRefresh(
      {@required RefreshController controller,
      @required int responseDataCount,
      @required int totalCount}) {
    if (controller.isRefresh) {
      controller.refreshCompleted(resetFooterState: true);
    }
    if (responseDataCount == totalCount) {
      controller.loadNoData();
    } else {
      controller.resetNoData();
    }
  }

  ///在加载更多网络数据返回后调用
  static updateAfterLoadMore(
      {@required RefreshController controller,
      @required int mergedDataCount,
      @required int totalCount}) {
    if (mergedDataCount >= totalCount) {
      controller.loadNoData();
    } else {
      controller.loadComplete();
    }
  }
}

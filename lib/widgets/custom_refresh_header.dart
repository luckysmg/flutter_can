import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;

///
/// @created by 文景睿
/// description:自定义的交刷新指示头部
///
class CustomRefreshHeader extends RefreshIndicator {
  final String imgPath;

  CustomRefreshHeader({this.imgPath = ''});

  @override
  State<StatefulWidget> createState() {
    return _DouBanRefreshHeaderState();
  }
}

class _DouBanRefreshHeaderState
    extends RefreshIndicatorState<CustomRefreshHeader>
    with TickerProviderStateMixin {
  AnimationController _scaleAnimation;
  AnimationController _rotateAnimation;
  var indicator;
  var textContent;
  var img;

  @override
  void initState() {
    _scaleAnimation = AnimationController(vsync: this);
    _rotateAnimation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _rotateAnimation.reset();
          _rotateAnimation.forward();
        }
      });
    img = LoadAssetImage(
      widget.imgPath,
      fit: BoxFit.contain,
    );
    super.initState();
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    if (mode == RefreshStatus.idle ||
        mode == RefreshStatus.canRefresh ||
        mode == RefreshStatus.completed) {
      indicator = ScaleTransition(
        scale: _scaleAnimation,
        child: LoadAssetImage(
          'ic_pull',
          width: 30,
        ),
      );

      if (mode == RefreshStatus.canRefresh) {
        textContent = "松开刷新";
      } else if (mode == RefreshStatus.idle) {
        textContent = "下拉刷新";
      }
    } else if (mode == RefreshStatus.refreshing) {
      indicator = RotationTransition(
        alignment: Alignment.center,
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,
          color: ColorUtil.mainColor,
        ),
        turns: _rotateAnimation,
      );
      textContent = "加载中";
    }

    if (mode == RefreshStatus.completed) {
      indicator = LoadAssetImage(
        'ic_complete',
        height: 30,
      );
      textContent = '加载完成';
    }

    return Container(
        height: 30,
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            indicator,
            SizedBox(
              width: 10,
            ),
            Container(
              width: ScreenUtil().setWidth(120),
              child: Text(textContent,
                  style: TextStyle(
                      color: ColorUtil.auxiliaryTextColor,
                      fontSize: Constants.auxiliaryTextSize)),
            )
          ],
        ));
  }

  @override
  void onModeChange(RefreshStatus mode) {
    if (mode == RefreshStatus.refreshing) {
      _rotateAnimation.forward();
    }
    super.onModeChange(mode);
  }

  @override
  void onOffsetChange(double offset) {
    if (!floating) {
      _scaleAnimation.value = offset / 60.0;
    }
    super.onOffsetChange(offset);
  }

  @override
  void resetValue() {
    _scaleAnimation.value = 0.0;
    _rotateAnimation.value = 0.0;
  }

  @override
  void dispose() {
    _scaleAnimation.dispose();
    _rotateAnimation.dispose();
    super.dispose();
  }
}

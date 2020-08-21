import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/gap.dart';

///
/// @created by 文景睿
/// description:统一的加载布局
///
// ignore: must_be_immutable
class LoadingView extends StatelessWidget {
  double topDistance;

  LoadingView({Key key, this.topDistance = -1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (topDistance == -1) {
      topDistance = ScreenUtil.screenHeightDp * 0.4;
    }
    return Column(
      children: <Widget>[
        //Gap.makeGap(height: topDistance),
        Gap.makeGap(height: 100),
        Center(
          child: Container(
            width: 40,
            child: LoadingIndicator(
              indicatorType: Indicator.ballClipRotatePulse,
              color: ColorUtil.mainColor,
            ),
          ),
        ),
      ],
    );
  }
}

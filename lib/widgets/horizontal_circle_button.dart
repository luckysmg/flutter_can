import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';

///
/// @created by 文景睿
/// description:水平方向为圆形的反馈型按钮
///
class HorizontalCircleButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final double horizontalPadding;
  final double verticalPadding;
  final Widget child;
  final double radius;
  final double width;

  const HorizontalCircleButton({
    Key key,
    this.color,
    this.onTap,
    this.horizontalPadding = 50.0,
    this.verticalPadding = 5.0,
    this.child,
    this.radius = 30,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? ScreenUtil.screenWidthDp,
      margin: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: CupertinoButton(
        pressedOpacity: 0.7,
        disabledColor: ColorUtil.disabledButtonColor,
        padding: const EdgeInsets.only(),
        borderRadius: BorderRadius.circular(radius),
        color: color ?? ColorUtil.mainColor,
        onPressed: onTap,
        child: Container(
            alignment: Alignment.center, width: double.infinity, child: child),
      ),
    );
  }
}

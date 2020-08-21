import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';

///
/// @created by 文景睿
/// description:封装的bottomBar
///
class BottomBar extends StatelessWidget {
  final Widget child;

  const BottomBar({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

//    final Color backgroundColor = CupertinoDynamicColor.resolve(
//      CupertinoTheme.of(context).barBackgroundColor,
//      context,
//    );

    Widget result = Container(
      constraints: BoxConstraints(maxWidth: ScreenUtil.screenWidthDp),
      alignment: Alignment.center,
      color: ColorUtil.whiteColor,

      ///此高度参照淘宝，并参照CupertinoTabBar源码的标准高度
      height: 50 + bottomPadding,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: child,
      ),
    );
    result = ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: result,
      ),
    );

    return result;
  }
}

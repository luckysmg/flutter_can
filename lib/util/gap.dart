import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/constants.dart';

import 'color_util.dart';

///
/// @created by 文景睿
/// description:生成间隔工具类
///
class Gap {
  const Gap._();

  ///自动配置间隔
  static Widget makeGap({double height = 0.0, double width = 0.0}) {
    return SizedBox(height: height, width: width);
  }

  static Widget makeSliverGap({double height = 0.0, double width = 0.0}) {
    return SliverToBoxAdapter(child: SizedBox(height: height, width: width));
  }

  static Widget line({
    double lPadding = 0.0,
    double rPadding = 0.0,
  }) {
    return Divider(
      indent: lPadding,
      endIndent: rPadding,
      height: 1.0,
    );
  }

  static Widget makeLineWithThickness({double thicknessHeight = 1.0}) {
    return Divider(
      height: thicknessHeight,
      color: ColorUtil.auxiliaryColor,
      thickness: thicknessHeight,
    );
  }

  static Widget vLine = const SizedBox(
    width: 0.6,
    height: 24.0,
    child: const VerticalDivider(),
  );
  static const Widget empty = const SizedBox();

  static Widget sliverEmpty = const SliverToBoxAdapter();
}

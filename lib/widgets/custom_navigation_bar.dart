import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';

import 'load_asset_image.dart';

///
/// @created by 文景睿
/// description:自定义封装NavigationBar
///
class CustomNavigationBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(44.0);
  final String title;
  final Widget trailing;
  final bool transitionBetweenRoutes;
  final bool fullScreenDialog;
  final VoidCallback onTapTitle;

  ///状态栏文字颜色是否为黑色
  final bool blackBarTextColor;

  ///没有border
  final bool noBorder;

  ///背景颜色
  final Color backgroundColor;

  ///是否是黑色的返回键
  final bool darkIcon;

  ///title的颜色
  final Color textColor;

  CustomNavigationBar({
    Key key,
    this.blackBarTextColor = true,
    this.onTapTitle,
    this.textColor = Colors.black,
    this.backgroundColor,
    this.title = '',
    this.trailing = Gap.empty,
    this.transitionBetweenRoutes = true,
    this.fullScreenDialog = false,
    this.noBorder = false,
    this.darkIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      border: noBorder
          ? null
          : Border(
              bottom: BorderSide(
                color: Color(0x4D000000),
                width: 0.0, // One physical pixel.
                style: BorderStyle.solid,
              ),
            ),
      backgroundColor: backgroundColor,
      transitionBetweenRoutes: transitionBetweenRoutes,
      leading: _buildLeading(context),
      trailing: trailing,
      middle: GestureDetector(
        onTap: onTapTitle,
        child: Text(title,
            style: TextStyle(
                fontSize: Constants.secondTitleTextSize,
                fontWeight: FontWeight.w500,
                color: ColorUtil.mainTextColor)),
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Icon(
        fullScreenDialog ? Icons.arrow_back_ios : Icons.arrow_back_ios,
        size: Constants.backIconSize,
        color: darkIcon ? Colors.black87 : Colors.white,
      ),
    );
  }
}

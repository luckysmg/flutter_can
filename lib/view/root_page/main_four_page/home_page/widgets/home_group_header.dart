import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';

///
/// @created by 文景睿
/// description:首页的分组头部内部的头部控件
///
class HomeGroupHeader extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const HomeGroupHeader({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
                fontSize: Constants.secondTitleTextSize,
                fontWeight: FontWeight.w500,
                color: ColorUtil.mainTextColor),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              '查看全部',
              style: TextStyle(
                  fontSize: Constants.auxiliaryTextSize,
                  color: ColorUtil.auxiliaryTextColor),
            ),
          ),
        ],
      ),
    );
    ;
  }
}

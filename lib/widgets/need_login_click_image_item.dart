import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/widgets/load_asset_image.dart';

///
/// @created by 文景睿
/// description:ClickImageItem的登陆拦截版（如果没登录去登陆）
///
class NeedLoginClickImageItem extends StatelessWidget {
  const NeedLoginClickImageItem({
    Key key,
    this.onTap,
    @required this.title,
    this.content: "",
    this.textAlign: TextAlign.start,
    this.maxLines: 1,
    @required this.imageLocal,
    this.imageLocalHeight: 30.0,
    this.imageLocalWeight: 30.0,
  }) : super(key: key);

  final Function onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final int maxLines;
  final String imageLocal;
  final double imageLocalHeight;
  final double imageLocalWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (UserProfileUtil.isUserLogin()) {
          onTap();
          return;
        }
        UserProfileUtil.pushLoginPage(context);
      },
//      onTap: UserProfileUtil.isUserLogin()
//          ? onTap
//          : () {
//              NavigatorUtil.push(context, LoginPage().buildPage(null),
//                  fullScreenDialog: true, rootNavigator: true);
//            },
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 0.0, 16.0, 0.0),
        constraints:
            BoxConstraints(maxHeight: double.infinity, minHeight: 50.0),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: maxLines == 1
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: Constants.mainTextSize),
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 15.0),
                child: Text(
                  content,
                  maxLines: maxLines,
                  textAlign: maxLines == 1 ? TextAlign.right : textAlign,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(fontSize: 14.0),
                ),
              ),
            ),
            Opacity(
              // 无点击事件时，隐藏箭头图标
              opacity: onTap == null ? 0 : 1,
              child: Padding(
                  padding: EdgeInsets.only(top: maxLines == 1 ? 0.0 : 2.0),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    size: 20,
                    color: ColorUtil.mainTextColor,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

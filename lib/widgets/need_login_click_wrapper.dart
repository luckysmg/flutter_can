import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/user_profile_util.dart';

///
/// @created by 文景睿
/// description:只有用户登陆后才会触发传入的点击事件，否则跳转登陆页面
///
class NeedLoginClickWrapper extends StatefulWidget {
  final Function onTap;
  final Widget child;
  final HitTestBehavior behavior;

  const NeedLoginClickWrapper({
    Key key,
    @required this.onTap,
    @required this.child,
    this.behavior = HitTestBehavior.deferToChild,
  }) : super(key: key);

  @override
  _NeedLoginClickWrapperState createState() => _NeedLoginClickWrapperState();
}

class _NeedLoginClickWrapperState extends State<NeedLoginClickWrapper> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onTap: () {
        if (UserProfileUtil.isUserLogin()) {
          widget.onTap();
          return;
        }
        UserProfileUtil.pushLoginPage(context);
      },
      child: widget.child,
    );
  }
}

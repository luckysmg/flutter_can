import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

///
/// @created by 文景睿
/// description:包装类，状态栏改变
///
class StatusBarWrapper extends StatefulWidget {
  final Widget child;
  final bool statusBarTextIsBlack;

  StatusBarWrapper({Key key, this.child, this.statusBarTextIsBlack = true})
      : super(key: key);

  @override
  _StatusBarWrapperState createState() => _StatusBarWrapperState();
}

class _StatusBarWrapperState extends State<StatusBarWrapper> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      explicitChildNodes: true,
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: widget.statusBarTextIsBlack
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        child: Semantics(
          explicitChildNodes: true,
          child: widget.child,
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';

///
/// @created by 文景睿
/// description:登陆按钮的同一封装
///
class LoginButton extends StatefulWidget {
  final VoidCallback onTap;

  ///震动，默认为true，提高交互体验
  final bool feedBack;

  const LoginButton({Key key, this.onTap, this.feedBack = true})
      : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  static Color pressedColor = ColorUtil.disabledButtonColor;
  static Color normalColor = ColorUtil.mainColor;
  Color color;

  @override
  void initState() {
    super.initState();
    color = normalColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.feedBack && widget.onTap != null) {
          HapticFeedback.heavyImpact();
        }
        widget.onTap();
      },
      onTapUp: (d) {
        setState(() {
          color = normalColor;
        });
      },
      onTapDown: (detail) {
        setState(() {
          color = pressedColor;
        });
      },
      onTapCancel: () {
        setState(() {
          color = normalColor;
        });
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color:
                widget.onTap == null ? ColorUtil.disabledButtonColor : color),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ).center(),
    );
  }
}

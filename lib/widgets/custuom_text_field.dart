import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';

///
/// @created by 文景睿
/// description:封装了登陆模块的输入样式
///
class CustomTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final InputDecoration decoration;
  final TextStyle style;
  final String hitText;
  final TextStyle hintTextStyle;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final String headerText;
  final bool obscureText;

  CustomTextField({
    Key key,
    @required this.controller,
    @required this.focusNode,
    @required this.headerText,
    this.decoration,
    this.style,
    this.hitText = '',
    this.hintTextStyle,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(headerText)
            .withStyle(
                fontSize: Constants.mainTextSize,
                color: ColorUtil.auxiliaryTextColor)
            .paddingLeft(0),
        Gap.makeGap(height: 8),
        TextField(
          obscureText: obscureText,
          focusNode: focusNode,
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: TextStyle(fontSize: Constants.inputTextSize),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ).backgroundColor(ColorUtil.auxiliaryColor).cornerRadius(4),
      ],
    ).paddingSymmetric(horizontal: 15);
  }
}

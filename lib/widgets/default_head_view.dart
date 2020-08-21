import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neng/widgets/load_asset_image.dart';

///
/// @created by 文景睿
/// description:默认的头像
///
class DefaultHeadView extends StatelessWidget {
  final double width;
  final double height;

  const DefaultHeadView({Key key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadAssetImage(
      'default/default_head',
      width: width,
      height: height,
    );
  }
}

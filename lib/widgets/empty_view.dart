import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/widgets/load_asset_image.dart';

///
/// @created by 文景睿
/// description:空视图
///
class EmptyView extends StatelessWidget {
  const EmptyView({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Gap.makeGap(height: 20),
            LoadAssetImage(
              'default/pic_blank_data',
              fit: BoxFit.fitWidth,
              width: 150,
            ),
            Gap.makeGap(height: 50),
            Text(
              title == null ? '暂无数据' : title,
              style: TextStyle(
                  color: ColorUtil.auxiliaryTextColor,
                  fontSize: Constants.auxiliaryTextSize),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/widgets/load_asset_image.dart';

///
/// @created by 文景睿
/// description:网络错误的页面
///
class NetworkErrorView extends StatelessWidget {
  final VoidCallback onTapButton;

  const NetworkErrorView({Key key, this.onTapButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Gap.makeGap(height: 50),
            LoadAssetImage(
              'default/pic_blank_network',
              fit: BoxFit.fitWidth,
              width: 150,
            ),
            Gap.makeGap(height: 40),
            GestureDetector(
                onTap: onTapButton,
                child: Container(
                    decoration: BoxDecoration(
                      color: ColorUtil.mainColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      child: Text(
                        '重新加载',
                        style: TextStyle(
                            color: ColorUtil.darkBackTextColor,
                            fontSize: Constants.auxiliaryTextSize),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}

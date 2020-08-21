import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/widgets/load_asset_image.dart';

///
/// @created by 文景睿
/// description:需要操作的界面
///
class NeedActionView extends StatefulWidget {
  ///点击按钮触发的事件
  final VoidCallback onTapButton;

  ///按钮文字
  final String buttonText;

  ///图片路径
  final String imgPath;

  const NeedActionView(
      {Key key,
      this.onTapButton,
      this.buttonText,
      this.imgPath = 'ico_home_selected'})
      : super(key: key);

  @override
  _NeedActionViewState createState() => _NeedActionViewState();
}

class _NeedActionViewState extends State<NeedActionView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Gap.makeGap(height: 40),
          LoadAssetImage(widget.imgPath),
          Gap.makeGap(height: 50),
          CupertinoButton.filled(
            child: Text(widget.buttonText,
                style: TextStyle(fontSize: ScreenUtil().setSp(30))),
            onPressed: widget.onTapButton,
          )
        ],
      ),
    );
  }
}

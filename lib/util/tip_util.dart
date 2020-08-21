import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/image_util.dart';
import 'package:neng/widgets/load_asset_image.dart';

import 'constants.dart';

///
/// @created by 文景睿
/// description:逼格极高的提示控件
///
class TipUtil {
  TipUtil._();

  static Future<void> show(
      {@required BuildContext context,
      @required String message,
      int timeInMs = 1400,
      String imgPath = 'success'}) async {
    OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
      return TipContent(
        msg: message,
        imgPath: imgPath,
        timeInMs: timeInMs,
      );
    });
    Overlay.of(context).insert(overlayEntry);
    await Future.delayed(Duration(milliseconds: timeInMs)).then((value) {
      overlayEntry.remove();
    });
    await Future.delayed(Duration(milliseconds: 200));
  }

  static Future<void> showWaring(
      {@required BuildContext context,
      @required String message,
      int timeInMs = 1500,
      String imgPath = Constants.TIP_WARNING}) async {
    OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
      return TipContent(
        msg: message,
        imgPath: imgPath,
        timeInMs: timeInMs,
      );
    });
    Overlay.of(context).insert(overlayEntry);
    await Future.delayed(Duration(milliseconds: timeInMs)).then((value) {
      overlayEntry.remove();
    });
    await Future.delayed(Duration(milliseconds: 100));
  }
}

class TipContent extends StatefulWidget {
  final String msg;
  final String imgPath;
  final int timeInMs;

  const TipContent({Key key, this.msg, this.imgPath, this.timeInMs})
      : super(key: key);

  @override
  TipContentState createState() => TipContentState();
}

class TipContentState extends State<TipContent> {
  var opacity;

  @override
  void initState() {
    super.initState();
    opacity = 1.0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(ImageUtil.getAssetImage(widget.imgPath), context);
    });
    Future.delayed(Duration(milliseconds: widget.timeInMs - 200), () {
      setState(() {
        opacity = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height * 0.4,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 200),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    color: Colors.white70,
                    padding: EdgeInsets.only(
                        bottom: 20, top: 10, left: 10, right: 10),
                    width: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        LoadAssetImage(
                          widget.imgPath,
                          width: 40,
                        ),
                        Gap.makeGap(height: 20),
                        Text(
                          widget.msg ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w300,
                            fontSize: Constants.auxiliaryTextSize,
                            color: ColorUtil.auxiliaryTextColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

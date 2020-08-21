import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as screen;
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:page_indicator/page_indicator.dart';

///引导页
class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screen.ScreenUtil.instance =
        screen.ScreenUtil(width: 750, height: 1334, allowFontScaling: false)
          ..init(context);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        PageIndicatorContainer(
          padding: EdgeInsets.only(bottom: screen.ScreenUtil().setHeight(50)),
          child: PageView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              ///引导图，还没有进入资源
              LoadAssetImage('app_start_1'),
              LoadAssetImage('app_start_2'),
              LoadAssetImage('app_start_3'),
            ],
          ),
          length: 3,
          indicatorSpace: 8,
          indicatorColor: ColorUtil.secondaryColor,
          indicatorSelectorColor: ColorUtil.mainColor,
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: screen.ScreenUtil().setHeight(120)),
          child: CupertinoButton(
            pressedOpacity: 0.5,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            minSize: screen.ScreenUtil().setHeight(50),
            padding: EdgeInsets.symmetric(
                horizontal: screen.ScreenUtil().setWidth(30),
                vertical: screen.ScreenUtil().setWidth(16)),
            color: ColorUtil.mainColor,
            child: Text(
              '立即进入',
              style: TextStyle(
                  fontSize: Constants.mainTextSize,
                  color: ColorUtil.darkBackTextColor),
            ),
            onPressed: () {
              SpUtil.putBool(Constants.NEED_SHOW_GUIDE, false);
              Navigator.pushReplacementNamed(context, 'root');
            },
          ),
        ),
      ],
    ));
  }
}

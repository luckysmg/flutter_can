import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';

class Constants {
  Constants._();

  //appBar 图标尺寸
  static const double backIconSize = 22.0;

  ///登录注册标题文字以及appBar标题文字Size
  static final double titleTextSize = ScreenUtil().setSp(40);

  ///二级标题文字Size
  static final double secondTitleTextSize = ScreenUtil().setSp(36);

  ///主要文字Size
  static final double mainTextSize = ScreenUtil().setSp(32);

  ///二级文字Size
  static final double secondTextSize = ScreenUtil().setSp(28);

  ///输入框文字Size
  static final double inputTextSize = ScreenUtil().setSp(36);

  ///辅助文字Size
  static final double auxiliaryTextSize = ScreenUtil().setSp(24);

  //主要内容字体次色 //带删除线
  static final TextStyle lineThroughTextStyle = TextStyle(
      fontSize: ScreenUtil().setSp(24),
      color: ColorUtil.auxiliaryTextColor,
      decoration: TextDecoration.lineThrough);

  ///内容字体 ,html富文本显示
  static final TextStyle contentTextHtmlStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: ScreenUtil().setSp(34),
      height: 1.5);

  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String refreshTokenValidTime = 'refreshTokenValidTime';
  static const String INVALID = 'invalid';
  static String userDetailInfo = 'userDetailInfo';
  static const String ASSETS_IMG = 'assets/images/';

  /// App运行在Release环境时，inRelease为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inRelease = const bool.fromEnvironment("dart.vm.product");

  ///判断是否需要进入引导页
  static const NEED_SHOW_GUIDE = 'need_show_guide';

//  //辅助字体颜色
//  static final Color secondaryFontColor = ColorUtil.hexToColor('#a5a5a5');

  static const String TIP_WARNING = 'warning';
  static const String TIP_SUCCESS = 'success';

  static const delayMillsInPageView = 400;
  static const delayInit = 200;
  static const delayLoadMore = 300;
}

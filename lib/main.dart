import 'dart:io';
import 'dart:ui';

import 'package:flustars/flustars.dart' hide ScreenUtil;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neng/route/custom_transition_builder.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/view/guide_page.dart';
import 'package:neng/view/root_page/page.dart';
import 'package:neng/widgets/custom_footer_indicator.dart';
import 'package:neng/widgets/custom_refresh_header.dart';
import 'package:oktoast/oktoast.dart';
import 'package:orientation/orientation.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  await OrientationPlugin.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  var rootView;

  ///是否是一次打开app
  var needShowGuide;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.inactive:

        /// 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed:

        /// 应用程序可见，前台
        break;
      case AppLifecycleState.paused:

        /// 应用程序不可见，后台
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initCacheData();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    ///安卓适配布局
    if (Platform.isAndroid) {
      rootView = _androidRootView();
      return rootView;
    }

    ///ios适配布局
    rootView = _iosRootView();
    return rootView;
  }

  ///初始化缓存数据
  void initCacheData() async {
    needShowGuide = SpUtil.getBool(Constants.NEED_SHOW_GUIDE, defValue: true);
    GlobalStore.packageInfo = await PackageInfo.fromPlatform();
  }

  Widget _androidRootView() {
    return OKToast(
      dismissOtherOnShow: true,
      handleTouth: true,
      textPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      position: ToastPosition.center,
      radius: 2,
      backgroundColor: Colors.black87,
      movingOnWindowChange: true,
      child: RefreshConfiguration(
        topHitBoundary: double.infinity,
        bottomHitBoundary: double.infinity,
        maxUnderScrollExtent: double.infinity,
        hideFooterWhenNotFull: false,
        footerTriggerDistance: 0,
        headerTriggerDistance: 60,
        maxOverScrollExtent: double.infinity,
        headerBuilder: () => CustomRefreshHeader(),
        footerBuilder: () => CustomFooterIndicator(),
        child: MaterialApp(
          routes: <String, WidgetBuilder>{
            'splash': (BuildContext context) => GuidePage(),
            'root': (BuildContext context) => RootPage().buildPage(null),
          },
          theme: ThemeData(
              splashColor: Colors.transparent,
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              ),
              platform: TargetPlatform.android),
          debugShowCheckedModeBanner: false,
          title: '行星BOOM',
          initialRoute: needShowGuide ? 'splash' : 'root',
        ),
      ),
    );
  }

  Widget _iosRootView() {
    return OKToast(
      dismissOtherOnShow: true,
      position: ToastPosition.center,
      handleTouth: true,
      textPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      radius: 2,
      backgroundColor: Colors.black87,
      movingOnWindowChange: true,
      child: RefreshConfiguration(
        topHitBoundary: double.infinity,
        bottomHitBoundary: double.infinity,
        maxUnderScrollExtent: double.infinity,
        hideFooterWhenNotFull: false,
        footerTriggerDistance: 0,
        headerTriggerDistance: 60,
        maxOverScrollExtent: double.infinity,
        headerBuilder: () => CustomRefreshHeader(),
        footerBuilder: () => CustomFooterIndicator(),
        child: MaterialApp(
          routes: <String, WidgetBuilder>{
            'splash': (BuildContext context) => GuidePage(),
            'root': (BuildContext context) => RootPage().buildPage(null),
          },
          debugShowCheckedModeBanner: false,
          title: '行星BOOM',
          theme: ThemeData(
              cupertinoOverrideTheme: CupertinoThemeData(
                  scaffoldBackgroundColor:
                      CupertinoTheme.of(context).scaffoldBackgroundColor),
              splashColor: Colors.transparent,
              primaryColor: Colors.black,
              brightness: Brightness.light),
          initialRoute: needShowGuide ? 'splash' : 'root',
        ),
      ),
    );
  }
}

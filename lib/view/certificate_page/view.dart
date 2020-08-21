import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';

import 'state.dart';

Widget buildView(
    CertificateState state, Dispatch dispatch, ViewService viewService) {
  ScreenUtil(width: 750, height: 1334, allowFontScaling: false)
    ..init(viewService.context);

  var body = state.hasNetworkError
      ? NetworkErrorView(
          onTapButton: () => dispatch(LifecycleCreator.initState()),
        )
      : state.certificationData == null
          ? LoadingView()
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                viewService.buildComponent('leftList'),
                viewService.buildComponent('rightList'),
              ],
            );
  return Scaffold(
    appBar: CustomNavigationBar(title: '考证信息'),
    body: body,
  );
}

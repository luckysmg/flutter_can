import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/certificate_detail_page/page.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AllCertificateState state, Dispatch dispatch, ViewService viewService) {
  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else if (state.recommendCertificationData == null) {
    body = LoadingView();
  } else {
    body = SmartRefresher(
      enablePullUp: true,
      onRefresh: () => dispatch(LifecycleCreator.initState()),
      onLoading: () => dispatch(AllCertificateActionCreator.loadMore()),
      physics: const BouncingScrollPhysics(),
      controller: state.refreshController,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
        itemCount: state.recommendCertificationData.rows.length,
        itemBuilder: (context, index) => _item(state, dispatch, context, index),
      ),
    );
  }

  return Scaffold(
    appBar: CustomNavigationBar(
      title: '所有证书',
    ),
    body: body,
  );
}

Widget _item(AllCertificateState state, Dispatch dispatch, BuildContext context,
    int index) {
  var itemData = state.recommendCertificationData.rows[index];
  return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => NavigatorUtil.push(
            context,
            CertificateDetailPage()
                .buildPage({'oid': itemData.oid, 'title': itemData.name}),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(itemData.name,
                    style: TextStyle(
                        fontSize: Constants.mainTextSize,
                        fontWeight: FontWeight.w500)),
                Gap.makeGap(height: 10),
                Text(
                  '全国统考',
                  style: TextStyle(
                      fontSize: Constants.auxiliaryTextSize,
                      color: ColorUtil.auxiliaryTextColor),
                ),
              ],
            ),
          ),
          Gap.line()
        ],
      ));
}

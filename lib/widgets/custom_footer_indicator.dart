import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomFooterIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: _buildFooter,
    );
  }

  Widget _buildFooter(context, status) {
    var img;
    var textContent;
    if (status == LoadStatus.idle || status == LoadStatus.canLoading) {
      img = Gap.empty;
      textContent = '松手加载';
    }
    if (status == LoadStatus.loading) {
      img = Container(
        width: 20,
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          color: Colors.black38,
        ),
      );
      textContent = "加载中";
    } else if (status == LoadStatus.noMore) {
      img = Gap.empty;
      textContent = "没有更多数据了";
    } else if (status == LoadStatus.failed) {
      img = Gap.empty;
      textContent = '网络不给力,请检查网络';
    }
    return Container(
      height: Platform.isAndroid ? 60 : 90,
      child: Column(
        children: <Widget>[
          Container(
            height: Platform.isAndroid ? 60 : 90,
            padding: EdgeInsets.only(bottom: Platform.isAndroid ? 0 : 30),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                img,
                Text(textContent,
                    style: TextStyle(
                        color: ColorUtil.auxiliaryTextColor,
                        fontSize: Constants.auxiliaryTextSize)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/gap.dart';

import '../util/constants.dart';

class CustomFooterIndicator extends Footer {
  @override
  double get triggerDistance => 60;

  @override
  Widget contentBuilder(
      BuildContext context,
      LoadMode loadState,
      double pulledExtent,
      double loadTriggerPullDistance,
      double loadIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteLoad,
      bool success,
      bool noMore) {
    var textContent;
    if (noMore) {
      textContent = '没有更多数据';
      return CustomFooterWidget(
        textContent: textContent,
      );
    } else if (!success) {
      textContent = '加载失败';
      return CustomFooterWidget(
        textContent: textContent,
      );
    }

    if (enableInfiniteLoad) {
      if (loadState == LoadMode.loaded ||
          loadState == LoadMode.inactive ||
          loadState == LoadMode.drag) {
        textContent = '加载完成';
      } else {
        textContent = '加载中';
      }
    }
    switch (loadState) {
      case LoadMode.load:
        textContent = '正在加载';
        return CustomFooterWidget(
          showLoadingImg: true,
          textContent: textContent,
        );
        break;
      case LoadMode.armed:
        textContent = '正在加载';
        return CustomFooterWidget(
          showLoadingImg: true,
          textContent: textContent,
        );
        break;
      case LoadMode.loaded:
        textContent = '加载完成';
        break;
      case LoadMode.done:
        textContent = '加载完成';
        break;
      default:
        textContent = '';
    }
    return CustomFooterWidget(
      textContent: textContent,
    );
  }
}

class CustomFooterWidget extends StatefulWidget {
  final textContent;
  final bool showLoadingImg;

  const CustomFooterWidget(
      {Key key, this.textContent, this.showLoadingImg = false})
      : super(key: key);

  @override
  _CustomFooterWidgetState createState() => _CustomFooterWidgetState();
}

class _CustomFooterWidgetState extends State<CustomFooterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.topCenter,
      //padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.showLoadingImg
              ? Container(
                  width: 20,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballSpinFadeLoader,
                    color: Colors.black38,
                  ))
              : Gap.empty,
          SizedBox(
            width: 5,
          ),
          Container(
            child: Text(
              widget.textContent,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorUtil.auxiliaryTextColor,
                  fontSize: Constants.auxiliaryTextSize),
            ),
          ),
        ],
      ),
    );
  }
}

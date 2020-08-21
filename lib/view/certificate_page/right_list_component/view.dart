import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/certificate_detail_page/page.dart';

import 'state.dart';

Widget buildView(
    RightListState state, Dispatch dispatch, ViewService viewService) {
  return Expanded(
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: EasyRefresh(
          child: ListView(
            controller: state.scrollController,
            children: <Widget>[
              _item(state, dispatch, viewService.context),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _item(RightListState state, Dispatch dispatch, BuildContext context) {
  var titleText = state.certificationData.data[state.currentIndex].name;
  var itemList = state.certificationData.data[state.currentIndex].children;
  List<Widget> widgetList = List.generate(itemList.length, (i) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(
          context,
          CertificateDetailPage()
              .buildPage({'oid': itemList[i].oid, 'title': itemList[i].name}),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
          height: 45,
          decoration: BoxDecoration(
            border: Border.all(color: ColorUtil.secondaryTextColor, width: 0.5),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  itemList[i].name,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: Constants.secondTextSize,
                    color: ColorUtil.secondaryTextColor,
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                padding: EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    itemList[i].recommend == 'NO'
                        ? Gap.empty
                        : Text(
                            "推荐",
                            style: TextStyle(
                                fontSize: Constants.auxiliaryTextSize,
                                color: ColorUtil.redColor,
                                fontWeight: FontWeight.w500),
                          ),
                    itemList[i].hot == 'NO'
                        ? Gap.empty
                        : Text(
                            "热门",
                            style: TextStyle(
                                fontSize: Constants.auxiliaryTextSize,
                                color: ColorUtil.redColor,
                                fontWeight: FontWeight.w500),
                          ),
                  ],
                ),
              )
            ],
          )),
    );
  });
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Gap.makeGap(height: 10),

      ///每个子标题
      Text(
        titleText,
        style: TextStyle(
            fontSize: Constants.mainTextSize,
            fontWeight: FontWeight.w500,
            color: ColorUtil.mainTextColor),
      ),
      Gap.makeGap(height: 10),
      itemList.length == 0
          ? Padding(
              padding: EdgeInsets.only(left: 0, top: 0),
              child: Text(
                '暂无',
                style: TextStyle(
                    fontSize: Constants.mainTextSize,
                    color: ColorUtil.auxiliaryTextColor),
              ),
            )
          : Wrap(
              spacing: 10,
              runSpacing: 10,
              children: widgetList,
            ),
    ],
  );
}

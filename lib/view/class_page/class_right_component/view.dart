import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/class_list_page/page.dart';

import 'package:neng/util/constants.dart';
import 'state.dart';

Widget buildView(
    ClassRightState state, Dispatch dispatch, ViewService viewService) {
  return Expanded(
      child: Container(
    color: Colors.white,
    child: EasyRefresh(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: state
            .curriculumCategoryData.data[state.currentIndex].children.length,
        controller: state.scrollController,
        itemBuilder: (context, index) => _item(state, dispatch, context, index),
      ),
    ),
  ));
}

Widget _item(
    ClassRightState state, Dispatch dispatch, BuildContext context, int index) {
  var itemData =
      state.curriculumCategoryData.data[state.currentIndex].children[index];
  List<Widget> itemInfoList = List.generate(itemData.children.length, (i) {
    return GestureDetector(
      onTap: () {
//        TipUtil.show(context: context, message: itemData.children[i].name);
        NavigatorUtil.push(
            context,
            ClassListPage().buildPage({
              'oid': itemData.children[i].oid,
              'title': itemData.children[i].name
            }),
            rootNavigator: true);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        //width: 100,
        height: 36,
        //alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: ColorUtil.secondaryTextColor, width: 0.5),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          itemData.children[i].name,
          style: TextStyle(
            fontSize: Constants.secondTextSize,
            color: ColorUtil.secondaryTextColor,
          ),
        ),
      ),
    );
  });
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Gap.makeGap(height: 10),

      ///每个子标题
      Text(
        itemData.name,
        style: TextStyle(
            fontSize: Constants.mainTextSize,
            fontWeight: FontWeight.w500,
            color: ColorUtil.mainTextColor),
      ),
      Gap.makeGap(height: 10),
      itemData.children.length == 0
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
              children: itemInfoList,
            ),
    ],
  );
}

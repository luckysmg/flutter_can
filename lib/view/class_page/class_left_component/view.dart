import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/view/class_page/class_right_component/action.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ClassLeftState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: double.infinity,
    color: ColorUtil.auxiliaryColor,
    width: 100,
    child: EasyRefresh(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 40),
        shrinkWrap: true,
        itemCount: state.curriculumCategoryData.data.length,
        itemBuilder: (context, index) => _item(state, dispatch, context, index),
      ),
    ),
  );
}

Widget _item(
    ClassLeftState state, Dispatch dispatch, BuildContext context, int index) {
  var itemData = state.curriculumCategoryData.data[index];
  Color textColor = index == state.currentIndex
      ? ColorUtil.mainColor
      : ColorUtil.mainTextColor;
  return GestureDetector(
    onTap: () {
      if (state.currentIndex != index) {
        dispatch(ClassLeftActionCreator.switchIndex(index));
        dispatch(ClassRightActionCreator.switchIndex());
      }
    },
    behavior: HitTestBehavior.opaque,
    child: Container(
      color: state.currentIndex == index ? Colors.white : null,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          itemData.name,
          style: TextStyle(
              color: textColor,
              fontSize: Constants.secondTextSize,
              fontWeight: FontWeight.w500),
        ),
      ),
    ),
  );
}

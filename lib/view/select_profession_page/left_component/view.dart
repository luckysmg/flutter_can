import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/view/select_profession_page/right_component/action.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(LeftState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: double.infinity,
    color: ColorUtil.auxiliaryColor,
    width: 100,
    child: EasyRefresh(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 40),
        shrinkWrap: true,
        itemCount: state.professionListData.data.length,
        itemBuilder: (context, index) => _item(state, dispatch, context, index),
      ),
    ),
  );
}

Widget _item(
    LeftState state, Dispatch dispatch, BuildContext context, int index) {
  var itemData = state.professionListData.data[index];
  Color textColor = index == state.currentIndex
      ? ColorUtil.mainColor
      : ColorUtil.mainTextColor;
  return GestureDetector(
    onTap: () {
      if (state.currentIndex != index) {
        dispatch(LeftActionCreator.switchIndex(index));
        dispatch(RightActionCreator.switchIndex());
      }
    },
    behavior: HitTestBehavior.opaque,
    child: Container(
      color: state.currentIndex == index ? Colors.white : null,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(itemData.name,
            style: TextStyle(
                color: textColor,
                fontSize: Constants.secondTextSize,
                fontWeight: FontWeight.w500)),
      ),
    ),
  );
}

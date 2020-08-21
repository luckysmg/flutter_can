import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/view/certificate_page/right_list_component/action.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    LeftListState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: double.infinity,
    color: ColorUtil.auxiliaryColor,
    width: 100,
    child: EasyRefresh(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 40),
        shrinkWrap: true,
        itemCount: state.certificationData.data.length,
        itemBuilder: (context, index) => _item(state, dispatch, context, index),
      ),
    ),
  );
}

Widget _item(
    LeftListState state, Dispatch dispatch, BuildContext context, int index) {
  var itemData = state.certificationData.data[index];
  Color textColor = index == state.currentIndex
      ? ColorUtil.mainColor
      : ColorUtil.mainTextColor;
  return GestureDetector(
    onTap: () {
      if (state.currentIndex != index) {
        dispatch(LeftListActionCreator.switchIndex(index));
        dispatch(RightListActionCreator.switchIndex());
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
                fontSize: ScreenUtil().setSp(28),
                fontWeight: FontWeight.w500)),
      ),
    ),
  );
}

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/dialog_util.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/profession_detail_page/page.dart';
import 'package:neng/view/select_profession_page/right_component/action.dart';

import 'state.dart';

Widget buildView(RightState state, Dispatch dispatch, ViewService viewService) {
  var emptyView = SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.only(left: 16, top: 16),
      child: Text('暂无',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28), color: Colors.black54)),
    ),
  );

  return Expanded(
    child: Container(
      color: Colors.white,
      child: EasyRefresh.custom(
        scrollController: state.scrollController,
        slivers: <Widget>[
          state.professionListData.data[state.currentIndex].children.length == 0
              ? emptyView
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          _item(state, dispatch, context, index),
                      childCount: state.professionListData
                          .data[state.currentIndex].children.length),
                )
        ],
      ),
    ),
  );
}

Widget _item(RightState state, Dispatch dispatch, BuildContext context, index) {
  var itemData =
      state.professionListData.data[state.currentIndex].children[index];
  return GestureDetector(
    onTap: () {
      state.professionName = itemData.name;
      state.professionCode = itemData.oid;

      ///如果是从首页调过来的，那么直接去职业详情页面
      if (!state.isFromSettingPage) {
        NavigatorUtil.push(
            context,
            ProfessionDetailPage().buildPage(
                {'oid': itemData.oid, 'professionName': itemData.name}));
        return;
      }
      DialogUtil.showDialog(
        context: context,
        dialogHeight: ScreenUtil().setHeight(250),
        title: "确定将${state.professionName}设定为理想职业？",
        onCancel: () => Navigator.pop(context),
        onConfirm: () => dispatch(RightActionCreator.selectProfession({
          'professionName': state.professionName,
          'professionCode': state.professionCode
        })),
      );
    },
    behavior: HitTestBehavior.opaque,
    child: Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: ColorUtil.auxiliaryColor, width: 0.6),
      )),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15.7),
        child: Text(
          itemData.name,
          style: TextStyle(
              fontSize: Constants.secondTextSize,
              color: ColorUtil.mainTextColor),
        ),
      ),
    ),
  );
}

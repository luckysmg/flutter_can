import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/view/essay_detail_page/action.dart';
import 'package:neng/widgets/bottom_bar.dart';

import '../state.dart';

Widget buildView(
    EssayDetailState state, Dispatch dispatch, ViewService viewService) {
  return BottomBar(
    child: GestureDetector(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Colors.black26,
            isScrollControlled: true,
            builder: (context) {
              return _inputBoxView(context, dispatch, state);
            },
            context: viewService.context);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        color: ColorUtil.auxiliaryColor,
        height: 40,
        child: Text('说点什么吧',
            style: TextStyle(
                fontSize: Constants.secondTextSize,
                fontWeight: FontWeight.w500,
                color: ColorUtil.mainTextColor)),
      ),
    ),
  );
}

Widget _inputBoxView(
  BuildContext context,
  Dispatch dispatch,
  EssayDetailState state,
) {
  ///header
  var cancelStyle = TextStyle(
    color: ColorUtil.auxiliaryTextColor,
    fontSize: Constants.mainTextSize,
  );

  var publishStyle = TextStyle(
    color: ColorUtil.mainColor,
    fontSize: Constants.mainTextSize,
  );
  var header = Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
            onTap: () async {
              state.focusNode.unfocus();
              Navigator.pop(context);
            },
            child: Text('取消', style: cancelStyle)),
        GestureDetector(
            onTap: () => dispatch(EssayDetailActionCreator.comment()),
            child: Text('发布', style: publishStyle)),
      ],
    ),
  );

  var inputBox = Container(
    height: 120,
    width: ScreenUtil.screenWidthDp,
    child: TextField(
      autofocus: true,
      style: TextStyle(
          fontSize: Constants.mainTextSize, color: ColorUtil.mainTextColor),
      maxLines: 20,
      focusNode: state.focusNode,
      scrollPhysics: BouncingScrollPhysics(),
      controller: state.textEditingController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 16, right: 16, top: 10),
        hintText: '写下你的评论',
        border: InputBorder.none,
      ),
    ),
  );
  return Container(
    height: MediaQuery.of(context).viewInsets.bottom + 200,
    width: ScreenUtil.screenWidthDp,
    child: Material(
      child: Column(
        children: <Widget>[
          header,
          Gap.line(),
          inputBox,
        ],
      ),
    ),
  );
}

import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/view/book_detail_page/book_detail_bottom_component/action.dart';
import 'package:neng/widgets/bottom_bar.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/need_login_click_wrapper.dart';

import 'state.dart';

Widget buildView(
    BookDetailBottomState state, Dispatch dispatch, ViewService viewService) {
  return BottomBar(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              _buildCollectClickItem(state, dispatch, viewService),
              Gap.makeGap(width: 40),
              _buildCommentClickItem(state, dispatch, viewService),
            ],
          ),
          Gap.makeGap(width: 20),

          ///点击弹出真正的评论框
          Expanded(
            child: NeedLoginClickWrapper(
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
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: ColorUtil.auxiliaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
                alignment: Alignment.center,
                child: Text('我来讲两句...',
                    style: TextStyle(
                        color: ColorUtil.mainTextColor,
                        fontSize: Constants.secondTextSize)),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCollectClickItem(
  BookDetailBottomState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  bool hasCollected = state.bookDetailData.data.collectionStatus == "YES";
  return NeedLoginClickWrapper(
    onTap: () {
      dispatch(BookDetailBottomActionCreator.onCollect());
    },
    child: Row(
      children: <Widget>[
        LoadAssetImage(
          hasCollected ? 'ico_collect' : 'ico_collect_empty',
          width: 24,
        ),
        Gap.makeGap(width: 5),
        Text(
          state.bookDetailData.data.collectionNumber.toString(),
          style: TextStyle(
            fontSize: Constants.auxiliaryTextSize,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCommentClickItem(
    BookDetailBottomState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
//    onTap: () => dispatch(CertificateDetailActionCreator.scrollToComment()),
    behavior: HitTestBehavior.opaque,
    child: Row(
      children: <Widget>[
        LoadAssetImage(
          'ico_comment',
          width: 24,
        ),
        Gap.makeGap(width: 5),
        Text(
          state.commentsData.total.toString(),
          style: TextStyle(
            fontSize: Constants.auxiliaryTextSize,
          ),
        ),
      ],
    ),
  );
}

Widget _inputBoxView(
  BuildContext context,
  Dispatch dispatch,
  BookDetailBottomState state,
) {
  ///header
  var cancelStyle = TextStyle(
    color: Colors.black38,
    fontSize: ScreenUtil().setSp(30),
  );

  var publishStyle = TextStyle(
    color: Colors.blue,
    fontSize: ScreenUtil().setSp(30),
  );
  var header = Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            onTap: () {
              if (state.textEditingController.text != null &&
                  state.textEditingController.text.isNotEmpty)
                dispatch(BookDetailBottomActionCreator.addComment());
            },
            child: Text('发布', style: publishStyle)),
      ],
    ),
  );

  var inputBox = Container(
    height: 120,
    width: ScreenUtil.screenWidthDp,
    child: TextField(
      autofocus: true,
      style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colors.black87),
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
    height: Platform.isAndroid
        ? MediaQuery.of(context).viewInsets.bottom + 200
        : 535,
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

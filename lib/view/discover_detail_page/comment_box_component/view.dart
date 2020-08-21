import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/widgets/bottom_bar.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/need_login_click_wrapper.dart';

import '../action.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    CommentBoxState state, Dispatch dispatch, ViewService viewService) {
  return BottomBar(
    child: Padding(
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          //bottom: Platform.isAndroid ? 10.0 : 30.0,
          top: 5,
          bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ///点击弹出真正的评论框
          Expanded(
            child: NeedLoginClickWrapper(
              behavior: HitTestBehavior.opaque,
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
          Gap.makeGap(width: 20),
          Row(
            children: <Widget>[
              _buildCommentClickItem(state, dispatch, viewService),
              Gap.makeGap(width: 15),
              _buildLikeClickItem(state, dispatch, viewService),
              Gap.makeGap(width: 15),
              _buildCollectClickItem(state, dispatch, viewService),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildCommentClickItem(
    CommentBoxState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () => dispatch(DiscoverDetailActionCreator.scrollToComment()),
    behavior: HitTestBehavior.opaque,
    child: Row(
      children: <Widget>[
        LoadAssetImage(
          'ico_comment',
          width: 24,
        ),
        Gap.makeGap(width: 5),
        Text(
          state.commentData.total.toString(),
          style: TextStyle(
              fontSize: Constants.auxiliaryTextSize,
              color: ColorUtil.auxiliaryTextColor),
        ),
      ],
    ),
  );
}

Widget _buildCollectClickItem(
  CommentBoxState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  return NeedLoginClickWrapper(
    onTap: () {
      bool hasCollected;
      if (state.detailData.data.collectionStatus == "YES") {
        hasCollected = true;
      } else {
        hasCollected = false;
      }
      dispatch(CommentBoxActionCreator.onCollect(hasCollected));
    },
    child: Row(
      children: <Widget>[
        LoadAssetImage(
          state.detailData.data.collectionStatus == 'YES'
              ? 'ico_collect'
              : 'ico_collect_empty',
          width: 26,
        ),
        Gap.makeGap(width: 5),
        Text(
          state.detailData.data.collectionNumber.toString(),
          style: TextStyle(
              fontSize: Constants.auxiliaryTextSize,
              color: ColorUtil.auxiliaryTextColor),
        ),
      ],
    ),
  );
}

Widget _buildLikeClickItem(
  CommentBoxState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  return NeedLoginClickWrapper(
    onTap: () {
      bool hasLike;
      if (state.detailData.data.likeStatus == "YES") {
        hasLike = true;
      } else {
        hasLike = false;
      }
      dispatch(CommentBoxActionCreator.onLike(hasLike));
    },
    child: Row(
      children: <Widget>[
        LoadAssetImage(
          state.detailData.data.likeStatus == 'YES'
              ? 'ico_praise'
              : 'ico_praise_empty',
          width: 26,
        ),
        Gap.makeGap(width: 5),
        Text(
          state.detailData.data.likeNumber.toString(),
          style: TextStyle(
              fontSize: Constants.auxiliaryTextSize,
              color: ColorUtil.auxiliaryTextColor),
        ),
      ],
    ),
  );
}

Widget _inputBoxView(
  BuildContext context,
  Dispatch dispatch,
  CommentBoxState state,
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
            onTap: () {
              dispatch(DiscoverDetailActionCreator.onAddComment());
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

import 'package:fijkplayer/fijkplayer.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/view/class_detail_page/detail_comment_page/page.dart';
import 'package:neng/view/class_detail_page/introduction_page/page.dart';
import 'package:neng/widgets/back_icon_view.dart';
import 'package:neng/widgets/network_error_view.dart';

import 'state.dart';
import 'widgets/video_controller_view.dart';

Widget buildView(
    ClassDetailState state, Dispatch dispatch, ViewService viewService) {
  var body;

  Widget videoView = Hero(
    tag: 'video',
    child: FijkView(
        player: state.player,
        color: Colors.black,
        panelBuilder: (player, data, ctx, viewSize, rect) {
          return VideoControllerView(
            player: player,
            viewSize: viewSize,
            texturePos: rect,
            buildContext: ctx,
          );
        }),
  );

  ///除了视频之外的布局
  var contentView;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else {
    ///除了视频之外的布局,也就是下面的简介和评论
    contentView = Expanded(
        child: PageView(
      controller: state.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        ///简介页
        IntroductionPage().buildPage({'oid': state.oid}).keepAlive(),

        ///评论页面
        DetailCommentPage().buildPage({'oid': state.oid}).keepAlive(),
      ],
    ));

    body = Column(
      children: <Widget>[
        ///模拟视频布局
        Stack(
          children: <Widget>[
            videoView.withHeight(180),
            BackIconView(
              darkIcon: false,
            ).offset(offset: const Offset(16, 10)),
          ],
        ),

        ///tab
        _tabHeader(state, dispatch, viewService),
        Gap.line(),

        ///下面的view
        contentView,
      ],
    );
  }

  return Scaffold(
    appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
        )),
    body: body,
  );
}

///这块等视频做了在做到纹理界面上面去
//Widget _buildTrailing(
//    ClassDetailState state, Dispatch dispatch, ViewService viewService) {
//  return Material(
//    child: PopupMenuButton(
//        offset: Offset(0, 10),
//        child: LoadAssetImage(
//          Constants.moreIcon,
//          width: Constants.backIconSize,
//          color: Colors.black87,
//        ),
//        elevation: 1.0,
//        padding: EdgeInsets.all(0),
//        onSelected: (index) {
//          if (index == 0) {
//            dispatch(ClassDetailActionCreator.collect());
//          } else if (index == 1) {
//            TipUtil.show(context: viewService.context, message: '分享');
//          }
//        },
//        itemBuilder: (context) {
//          return <PopupMenuItem>[
//            _buildMenuItem(
//                dispatch,
//                viewService,
//                state.classDetailData.data.collectionStatus == 'NO'
//                    ? '收藏'
//                    : '取消收藏',
//                0),
//            _buildMenuItem(dispatch, viewService, '分享', 1),
//          ];
//        }),
//  );
//}

Widget _buildMenuItem(
    Dispatch dispatch, ViewService viewService, String text, int value) {
  return PopupMenuItem(
    value: value,
    child: SizedBox(
      width: 80,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Gap.makeGap(width: 5),
            Text(text,
                style: TextStyle(
                    color: ColorUtil.mainTextColor,
                    fontSize: Constants.mainTextSize)),
          ],
        ),
      ),
    ),
  );
}

///中间的tab头，包括两个tab，和购买课程的按钮
Widget _tabHeader(
    ClassDetailState state, Dispatch dispatch, ViewService viewService) {
  double tabItemWidth = 80;
  TextStyle tabStyle = TextStyle(
      color: ColorUtil.mainTextColor,
      fontSize: Constants.mainTextSize,
      fontWeight: FontWeight.w500);
  List<Widget> tabs = [
    Container(
      alignment: Alignment.center,
      width: tabItemWidth,
      child: Text(
        '详情',
        style: tabStyle,
      ),
    ),
    Container(
      alignment: Alignment.center,
      width: tabItemWidth,
      child: Text(
        '评论',
        style: tabStyle,
      ),
    ),
  ];

  return SizedBox(
    height: 55,
    child: Stack(
      children: <Widget>[
        Row(
          children: <Widget>[
            ///左边的tab选择部分
            Container(
              color: Theme.of(viewService.context).scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: DefaultTabController(
                length: 2,
                child: TabBar(
                  onTap: (index) => state.pageController.jumpToPage(index),
                  unselectedLabelColor: ColorUtil.mainTextColor,
                  isScrollable: true,
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                  labelColor: ColorUtil.mainColor,
                  tabs: tabs,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 30),
                  indicatorColor: ColorUtil.mainColor,
                ),
              ),
            ),

            const Spacer(),

            ///购买课程的按钮
            CupertinoButton(
                minSize: 0,
                borderRadius: BorderRadius.circular(2),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                color: ColorUtil.mainColor,
                child: Text('购买课程').withStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Constants.secondTextSize),
                onPressed: () {
                  ToastUtil.show('还未实现呢');
                }),
            Gap.makeGap(width: 15),
          ],
        ),

        ///中间那个竖线
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(left: 85),
            height: 20,
            width: 1,
            color: ColorUtil.secondaryColor,
          ),
        ),
      ],
    ),
  );
}

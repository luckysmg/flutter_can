import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/class_detail_page/page.dart';
import 'package:neng/widgets/custom_html_widget.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/empty_view.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CertificateDetailState state, Dispatch dispatch, ViewService viewService) {
  var body;

  if (state.hasNetworkError) {
    body = NetworkErrorView(
        onTapButton: () => dispatch(LifecycleCreator.initState()));
  } else if (!state.dataHasResp) {
    ///数据没回来就是loading
    body = LoadingView();
  } else if (state.detailData.data == null) {
    ///数据回来了但是没有数据，说明后台没有这个数据
    body = EmptyView(title: '暂无考试安排');
  } else {
    body = Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(viewService.context).padding.bottom + 50),
          child: SmartRefresher(
            physics: const BouncingScrollPhysics(),
            enablePullUp: state.commentsData.total > 10,
            enablePullDown: false,
            onLoading: () =>
                dispatch(CertificateDetailActionCreator.loadMore()),
            controller: state.refreshController,
            child: CustomScrollView(
              controller: state.scrollController,
              slivers: <Widget>[
                _item(state, dispatch, viewService, '考试介绍',
                    state.detailData.data.introduce),

                _schedule(state, dispatch, viewService),

                _item(state, dispatch, viewService, '报考条件',
                    state.detailData.data.conditions),

                _item(state, dispatch, viewService, '报考须知',
                    state.detailData.data.notice),

                _item(state, dispatch, viewService, '考试方式',
                    state.detailData.data.method),

                ///推荐课程的列表
                state.detailData.data.curriculums.length != 0
                    ? _classList(state, dispatch, viewService)
                    : Gap.makeSliverGap(),
                SliverToBoxAdapter(
                    child: Gap.makeLineWithThickness(thicknessHeight: 10.0)),

                ///评论列表
                viewService.buildComponent('commentsList'),
              ],
            ),
          ),
        ),

        ///评论框
        viewService.buildComponent('commentBox'),
      ],
    );
  }

  return Scaffold(
    appBar: CustomNavigationBar(
      title: state.title,
    ),
    body: body,
  );
}

Widget _item(CertificateDetailState state, Dispatch dispatch,
    ViewService viewService, String title, String data) {
  if (data == null || data == '') {
    return Gap.makeSliverGap();
  } else {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: ColorUtil.mainTextColor,
                fontSize: Constants.secondTitleTextSize,
                fontWeight: FontWeight.w500),
          ),
          CustomHtmlWidget(
            data: data,
          ),
        ],
      ),
    ));
  }
}

Widget _classList(state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Gap.makeLineWithThickness(thicknessHeight: 8),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 10),
          child: Text('推荐课程',
              style: TextStyle(
                  color: ColorUtil.mainTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: Constants.secondTitleTextSize)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SizedBox(
            height: 130,
            child: EasyRefresh(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: state.detailData.data.curriculums.length,
                  itemBuilder: (context, index) =>
                      _classItem(state, dispatch, context, index)),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _classItem(CertificateDetailState state, Dispatch dispatch,
    BuildContext context, int index) {
  var itemData = state.detailData.data.curriculums[index];
  return GestureDetector(
    onTap: () => NavigatorUtil.push(
        context, ClassDetailPage().buildPage({'oid': itemData.oid})),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 160,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: CachedNetworkImage(
              imageUrl: itemData.imageUrl,
              placeholder: (_, __) => LoadAssetImage(
                'default/pic_blank_curriculum',
                width: 160,
                fit: BoxFit.cover,
              ),
              errorWidget: (_, __, ___) => LoadAssetImage(
                  'default/pic_blank_curriculum',
                  width: 160,
                  fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(
          width: 160,
          child: Text(
            itemData.title,
            style: TextStyle(
                color: ColorUtil.mainTextColor,
                fontSize: Constants.mainTextSize),
            maxLines: 2,
          ),
        ),
      ],
    ),
  );
}

///时间安排
Widget _schedule(
    CertificateDetailState state, Dispatch dispatch, ViewService viewService) {
  //TextStyle style = Constants.contentTextStyle;
  var data = state.detailData.data.schedules[state.currentIndex];
  var beginEnlistTime = data.beginEnlistTime.substring(0, 10);
  var endEnlistTime = data.endEnlistTime.substring(0, 10);
  return SliverToBoxAdapter(
      child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '时间安排',
              style: TextStyle(
                  color: ColorUtil.mainTextColor,
                  fontSize: Constants.secondTitleTextSize,
                  fontWeight: FontWeight.w500),
            ),
            Gap.makeGap(width: 10),
            CupertinoButton.filled(
              disabledColor: Colors.black26,
              borderRadius: BorderRadius.all(Radius.circular(2)),
              minSize: 10,
              pressedOpacity: 0.7,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(data.provinceName,
                  style: TextStyle(
                      color: ColorUtil.darkBackTextColor,
                      fontSize: Constants.auxiliaryTextSize)),
              onPressed: state.detailData.data.schedules.length != 1
                  ? () {
                      showModalBottomSheet(
                          context: viewService.context,
                          builder: (context) {
                            return _buildBottomSheet(state, dispatch, context);
                          });
                    }
                  : null,
            ),
          ],
        ),
        Gap.makeGap(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '报名时间',
              style: TextStyle(
                  color: ColorUtil.mainTextColor,
                  fontSize: Constants.mainTextSize),
            ),
            Text(
              '$beginEnlistTime - $endEnlistTime',
              style: TextStyle(
                  color: ColorUtil.secondaryTextColor,
                  fontSize: Constants.mainTextSize),
            )
          ],
        ),
        Gap.makeGap(height: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '考试时间',
                style: TextStyle(
                    color: ColorUtil.mainTextColor,
                    fontSize: Constants.mainTextSize),
              ),
              Text(
                '${data.stageTime.substring(0, 10)}',
                style: TextStyle(
                    color: ColorUtil.secondaryTextColor,
                    fontSize: Constants.mainTextSize),
              ),
            ]),
        Gap.makeGap(height: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '考试费用',
                style: TextStyle(
                    color: ColorUtil.mainTextColor,
                    fontSize: Constants.mainTextSize),
              ),
              Text(
                '￥${data.fee}',
                style: TextStyle(
                    color: ColorUtil.redColor,
                    fontSize: Constants.mainTextSize),
              ),
            ]),
        Gap.makeGap(height: 20),
      ],
    ),
  ));
}

Widget _buildBottomSheet(
    CertificateDetailState state, Dispatch dispatch, BuildContext context) {
  //var headerStyle = Constants.firstTitleTextStyle;
  return Container(
    width: double.infinity,
    height: 260,
    child: Column(
      children: <Widget>[
        Container(
          height: 50,
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '选择考试地区',
                style: TextStyle(
                    color: ColorUtil.mainTextColor,
                    fontSize: Constants.mainTextSize),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  '取消',
                  style: TextStyle(
                      color: ColorUtil.mainTextColor,
                      fontSize: Constants.mainTextSize),
                ),
              ),
            ],
          ),
        ),
        Gap.line(),
        SizedBox(
          height: 200,
          child: EasyRefresh(
            child: ListView.builder(
                itemCount: state.detailData.data.schedules.length,
                itemBuilder: (ctx, index) {
                  return FlatButton(
                    onPressed: () {
                      dispatch(
                          CertificateDetailActionCreator.switchSchedulesIndex(
                              index));
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                          child: Text(
                              state.detailData.data.schedules[index]
                                  .provinceName,
                              style: TextStyle(
                                  color: ColorUtil.mainTextColor,
                                  fontSize: Constants.mainTextSize))),
                    ),
                  );
                }),
          ),
        ),
      ],
    ),
  );
}

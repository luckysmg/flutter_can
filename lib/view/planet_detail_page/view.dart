import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/view/planet_detail_page/edit_planet_introduction_page/page.dart';
import 'package:neng/view/planet_detail_page/edit_planet_notice_page/page.dart';
import 'package:neng/view/planet_detail_page/edit_planet_title_page/page.dart';
import 'package:neng/view/planet_info_page/action.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PlanetDetailState state, Dispatch dispatch, ViewService viewService) {
  var body;

  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else if (state.planetDetailEntity == null) {
    body = LoadingView();
  } else {
    body = EasyRefresh(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          _buildHeader(state, dispatch, viewService),
          Gap.makeLineWithThickness(thicknessHeight: 10),
          _buildIntroduction(state, dispatch, viewService),
          Gap.makeLineWithThickness(thicknessHeight: 10),
          _buildNotice(state, dispatch, viewService),
        ],
      ),
    );
  }

  return Scaffold(
    appBar: CustomNavigationBar(
      title: '星球详情',
    ),
    body: body,
  );
}

///头
Widget _buildHeader(
    PlanetDetailState state, Dispatch dispatch, ViewService viewService) {
  return Row(
    children: <Widget>[
      SizedBox(
          width: 100,
          height: 100,
          child: CachedNetworkImage(
            imageUrl: state.planetDetailEntity.data.img,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => LoadAssetImage(
              'default/pic_blank_planet',
              fit: BoxFit.cover,
            ),
          )).cornerRadius(4).onTap(() {
        ///如果是星主才能编辑图片
        if (state.planetDetailEntity.data.userOid ==
            UserProfileUtil.getUserDetailInfo().oid) {
          _showSheet(viewService.context, dispatch);
        }
      }),
      Gap.makeGap(width: 20),
      Text(state.planetDetailEntity.data.title).withStyle(
          fontSize: Constants.secondTitleTextSize, fontWeight: FontWeight.w500),
      Gap.makeGap(width: 10),
      _buildEditButton(state, dispatch, viewService, () async {
        bool changed = await NavigatorUtil.push(
                viewService.context,
                EditPlanetTitlePage(
                  currentTitle: state.planetDetailEntity.data.title ?? '',
                  oid: state.planetDetailEntity.data.oid,
                )) ??
            false;
        if (changed) {
          ///重新加载，刷新本页面
          dispatch(LifecycleCreator.initState());

          ///刷新行星详情页内容
          viewService.broadcast(PlanetInfoActionCreator.reload());
        }
      }),
    ],
  ).paddingSymmetric(horizontal: 16, vertical: 15);
}

///介绍
Widget _buildIntroduction(
    PlanetDetailState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Text('星球介绍').withStyle(
              fontWeight: FontWeight.w500,
              fontSize: Constants.secondTitleTextSize),
          const Spacer(),
          _buildEditButton(state, dispatch, viewService, () async {
            bool changed = await NavigatorUtil.push(
                    viewService.context,
                    EditPlanetIntroductionPage(
                      currentIntroduction:
                          state.planetDetailEntity.data.subtitle ?? '',
                      oid: state.planetDetailEntity.data.oid,
                    )) ??
                false;
            if (changed) {
              ///重新加载，刷新本页面
              dispatch(LifecycleCreator.initState());

              ///刷新行星详情页内容
              viewService.broadcast(PlanetInfoActionCreator.reload());
            }
          }),
        ],
      ),
      Gap.makeGap(height: 10),
      Text(state.planetDetailEntity.data.subtitle ?? '暂时没有介绍')
          .withStyle(fontSize: Constants.mainTextSize),
    ],
  ).paddingSymmetric(horizontal: 16, vertical: 15);
}

///公告
Widget _buildNotice(
    PlanetDetailState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Text('星球公告').withStyle(
              fontWeight: FontWeight.w500,
              fontSize: Constants.secondTitleTextSize),
          const Spacer(),
          _buildEditButton(state, dispatch, viewService, () async {
            bool changed = await NavigatorUtil.push(
                    viewService.context,
                    EditPlanetNoticePage(
                      currentNotice: state.planetDetailEntity.data.notice ?? '',
                      oid: state.planetDetailEntity.data.oid,
                    )) ??
                false;
            if (changed) {
              ///重新加载，刷新本页面
              dispatch(LifecycleCreator.initState());

              ///刷新行星详情页内容
              viewService.broadcast(PlanetInfoActionCreator.reload());
            }
          }),
        ],
      ),
      Gap.makeGap(height: 10),
      Text(
        state.planetDetailEntity.data.notice ?? "暂时没有公告",
        strutStyle: StrutStyle(height: 1.8),
      ).withStyle(fontSize: Constants.mainTextSize),
    ],
  ).paddingSymmetric(horizontal: 16, vertical: 15);
}

///这是编辑按钮，如果不是自己创建的星球（也就是自己如果不是星主，那么就不显示这个按钮）
Widget _buildEditButton(PlanetDetailState state, Dispatch dispatch,
    ViewService viewService, VoidCallback onTap) {
  if (state.planetDetailEntity.data.userOid ==
      UserProfileUtil.getUserDetailInfo().oid) {
    return LoadAssetImage(
      'function/ico_edit',
      width: 20,
      color: ColorUtil.mainColor,
    ).onTap(onTap);
  }
  return Gap.empty;
}

void _showSheet(BuildContext context, Dispatch dispatch) async {
  var useCamera;
  useCamera = await showModalBottomSheet<bool>(
      context: context,
      builder: (ctx) {
        var cameraItemView = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context, true);
          },
          child: Container(
            color: ColorUtil.whiteColor,
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                '拍照',
                style: TextStyle(
                  fontSize: Constants.mainTextSize,
                  color: ColorUtil.mainTextColor,
                ),
              ),
            ),
          ),
        );

        var imgItemView = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context, false);
          },
          child: Container(
            color: ColorUtil.whiteColor,
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                '相册',
                style: TextStyle(
                  fontSize: Constants.mainTextSize,
                  color: ColorUtil.mainTextColor,
                ),
              ),
            ),
          ),
        );

        return Container(
          color: ColorUtil.auxiliaryColor,
          height: Platform.isAndroid ? 150 : 180,
          child: Column(
            children: <Widget>[
              cameraItemView,
              Gap.line(),
              imgItemView,
              Gap.line(),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: Platform.isAndroid ? 50 : 80,
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.only(bottom: Platform.isAndroid ? 0 : 30),
                    width: double.infinity,
                    child: Text('取消',
                        style: TextStyle(
                            color: ColorUtil.mainTextColor,
                            fontSize: Constants.mainTextSize)),
                  ),
                ),
              )
            ],
          ),
        );
      });

  if (useCamera == null) {
    return;
  }
  dispatch(PlanetDetailActionCreator.selectImg(useCamera));
}

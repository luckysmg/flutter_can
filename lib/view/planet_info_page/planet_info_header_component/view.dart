import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/view/planet_info_page/action.dart';

import '../state.dart';

Widget buildView(
    PlanetInfoState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        state.planetDetailEntity.data.title,
      ).withStyle(
          fontWeight: FontWeight.w500, fontSize: Constants.titleTextSize),
      Gap.makeGap(height: 10),
      Text("${state.planetDetailEntity.data.subtitle ?? ''}").withStyle(
          fontSize: Constants.mainTextSize, color: ColorUtil.mainTextColor),
      Gap.makeGap(height: 50),
      Row(
        children: <Widget>[
          Text('${state.planetDetailEntity.data.userNum}人加入·${state.planetDetailEntity.data.essayNum}条动态')
              .withStyle(
                  fontSize: Constants.secondTextSize,
                  color: ColorUtil.mainTextColor),
        ],
      ),
      Gap.makeGap(height: 20),

      ///带有用户头像的那一栏
      _buildPlanetOwnerInfoView(state, dispatch, viewService),

      ///公告栏
      _buildNoticeView(state, dispatch, viewService),
    ],
  ).padding(left: 16, right: 16, top: 10).sliverBoxAdapter();
}

Widget _buildPlanetOwnerInfoView(
    PlanetInfoState state, Dispatch dispatch, ViewService viewService) {
  return Row(
    children: <Widget>[
      Text(state.galaxyOwnerName).withStyle(
          fontSize: Constants.secondTextSize, fontWeight: FontWeight.w500),
      Gap.makeGap(width: 5),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: ColorUtil.secondaryColor),
        child: Text('星主').withStyle(
            color: ColorUtil.mainTextColor,
            fontSize: Constants.auxiliaryTextSize),
      ),
      const Spacer(),

      ///加入按钮
      CupertinoButton(
          minSize: 0,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: state.planetDetailEntity.data.joinStatus == 'YES'
              ? ColorUtil.secondaryColor
              : ColorUtil.mainColor,
          child: Text(state.planetDetailEntity.data.joinStatus == 'YES'
                  ? '已加入'
                  : '加入')
              .withStyle(
            fontSize: Constants.secondTextSize,
            color: state.planetDetailEntity.data.joinStatus == 'YES'
                ? ColorUtil.secondaryTextColor
                : ColorUtil.darkBackTextColor,
          ),
          onPressed: () {
            if (state.planetDetailEntity.data.joinStatus == 'YES') {
              return;
            } else {
              dispatch(PlanetInfoActionCreator.joinPlanet());
            }
          }),
    ],
  );
}

///公告栏
Widget _buildNoticeView(
    PlanetInfoState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      const Divider(
        color: Colors.black12,
      ),
      Row(
        children: <Widget>[
          Text('公告').withStyle(
              fontWeight: FontWeight.w500,
              fontSize: Constants.secondTitleTextSize),
          Gap.makeGap(width: 10),
          Expanded(
            child: Text(
              state.planetDetailEntity.data.notice != null
                  ? state.planetDetailEntity.data.notice
                  : '暂无公告',
              maxLines: 1,
            ),
          ),

          ///右边的按钮
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black26,
            size: 16,
          ),
        ],
      ).paddingSymmetric(vertical: 6),
      const Divider(
        color: Colors.black12,
      ),
    ],
  ).onTap(() {
    showModalBottomSheet(
        context: viewService.context,
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) => _buildBottomSheet(state, dispatch, viewService));
  });
}

Widget _buildBottomSheet(
    PlanetInfoState state, Dispatch dispatch, ViewService viewService) {
  var header = Row(
    children: <Widget>[
      Text('公告').withStyle(
          fontSize: Constants.secondTitleTextSize, fontWeight: FontWeight.w500),
      const Spacer(),
      Icon(
        Icons.cancel,
        color: ColorUtil.secondaryColor,
        size: 24,
      ).onTap(() => Navigator.pop(viewService.context)),
    ],
  ).padding(left: 16, right: 16, top: 20);

  var content = Text(
    state.planetDetailEntity.data.notice != null
        ? state.planetDetailEntity.data.notice
        : "暂无公告",
    strutStyle: StrutStyle(height: 1.8),
  )
      .withStyle(
        fontSize: Constants.mainTextSize,
      )
      .paddingSymmetric(horizontal: 16);

  return SizedBox(
    height: ScreenUtil.screenHeightDp * 0.65,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[header, Gap.makeGap(height: 15), content],
    ),
  );
}

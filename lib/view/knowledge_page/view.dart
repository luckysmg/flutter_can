import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/view/build_planet_page/page.dart';
import 'package:neng/view/check_all_pages/all_galaxy_select_page/page.dart';
import 'package:neng/view/planet_info_page/page.dart';
import 'package:neng/view/root_page/main_four_page/profession_page/widgets/no_login_view.dart';
import 'package:neng/view/search_galaxy_page/page.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    KnowledgeState state, Dispatch dispatch, ViewService viewService) {
  ///已经定居标识
  bool hasSettled = UserProfileUtil.isUserLogin() &&
      UserProfileUtil.getUserDetailInfo().galaxyName != null;

  var body;

  ///没有登陆就先登录
  if (!UserProfileUtil.isUserLogin()) {
    body = NoLoginView();
  } else if (state.hasNetworkError) {
    body = NetworkErrorView(
        onTapButton: () => dispatch(LifecycleCreator.initState()));
  } else if (state.knowledgeListEntity == null) {
    body = LoadingView();
  } else {
    ///正常的view
    body = SmartRefresher(
      physics: const BouncingScrollPhysics(),
      onRefresh: () => dispatch(LifecycleCreator.initState()),
      onLoading: () => dispatch(KnowledgeActionCreator.loadMore()),
      controller: state.refreshController,
      child: CustomScrollView(
        slivers: <Widget>[
          _buildSearchBar(state, dispatch, viewService),
          _buildGridList(state, dispatch, viewService, hasSettled)
        ],
      ),
    );
  }

  return Scaffold(
    appBar: CustomNavigationBar(
      title: "知识行星",
      trailing: _buildTrailing(state, dispatch, viewService, hasSettled),
    ),
    body: body,
  );
}

Widget _buildTrailing(KnowledgeState state, Dispatch dispatch,
    ViewService viewService, bool hasSettled) {
  var style = TextStyle(fontSize: Constants.mainTextSize);
  return GestureDetector(
    onTap: () {
      if (hasSettled) {
        ///去构建星球
        NavigatorUtil.push(
            viewService.context, BuildPlanetPage().buildPage(null));
      }
//      else {
//        ///去定居
//        NavigatorUtil.push(
//            viewService.context, AllGalaxySelectPage().buildPage(null));
//      }
    },
    child: UserProfileUtil.isUserLogin()
        ? hasSettled
            ? Material(
                child: Icon(
                Icons.add_circle_outline,
                size: 26,
              ))
            : Gap.empty
//          Material(
//                child: Text(
//                  '去定居',
//                  style: style,
//                ),
//              )
        : Gap.empty,
  );
}

///下面的网格列表
Widget _buildGridList(KnowledgeState state, Dispatch dispatch,
    ViewService viewService, bool hasSettled) {
  return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 30,
          childAspectRatio: 0.75,
          mainAxisSpacing: 30),
      itemCount: state.knowledgeListEntity.rows.length + 1,
      itemBuilder: (context, index) {
        return _item(state, dispatch, context, index, hasSettled);
      }).paddingSymmetric(horizontal: 20).sliverBoxAdapter();
}

///网格列表中的item
Widget _item(KnowledgeState state, Dispatch dispatch, BuildContext context,
    int index, bool hasSettled) {
  ///如果是最后一个item那么返回特殊的item
  if (index == state.knowledgeListEntity.rows.length) {
    if (hasSettled) {
      return _buildAddPlanetItem(state, dispatch, context);
    } else {
      return _buildSettledItem(state, dispatch, context);
    }
  }

  var itemData = state.knowledgeListEntity.rows[index];

  ///否则返回正常的item
  return GestureDetector(
    onTap: () => NavigatorUtil.push(
        context,
        PlanetInfoPage().buildPage({
          'oid': itemData.oid,
          'galaxyOwnerName': itemData.nickName ?? "流浪者",
        })),
    child: Card(
      shape: const RoundedRectangleBorder(
        //修改圆角
        borderRadius: const BorderRadius.all(Radius.circular(2)),
      ),
      //阴影高度
      elevation: 1.0,
      child: Column(
        children: <Widget>[
          Expanded(
            child: itemData.img == "NONE"
                ? LoadAssetImage(
                    'default/pic_blank_planet',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    fadeInDuration: const Duration(milliseconds: 200),
                    imageUrl: itemData.img,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => LoadAssetImage(
                      'default/pic_blank_planet',
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (_, __, ___) => LoadAssetImage(
                      'default/pic_blank_planet',
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      itemData.title,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: Constants.mainTextSize,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      itemData.nickName ?? "流浪者",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: Constants.auxiliaryTextSize,
                          color: ColorUtil.auxiliaryTextColor),
                    ),
                  ],
                ),
              )),
        ],
      ),
    ),
  );
}

///构建星球的item
Widget _buildAddPlanetItem(
    KnowledgeState state, Dispatch dispatch, BuildContext context) {
  return GestureDetector(
      onTap: () {
        NavigatorUtil.push(context, BuildPlanetPage().buildPage(null));
      },
      child: Padding(
          padding: EdgeInsets.all(4),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorUtil.secondaryColor,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Gap.makeGap(height: ScreenUtil().setHeight(100)),
                Icon(
                  Icons.add,
                  size: 40,
                  color: ColorUtil.auxiliaryTextColor,
                ),
                Gap.makeGap(height: ScreenUtil().setHeight(80)),
                Text('构建星球').withStyle(
                    fontSize: Constants.mainTextSize,
                    color: ColorUtil.auxiliaryTextColor),
              ],
            ),
          )));
}

Widget _buildSettledItem(state, Dispatch dispatch, BuildContext context) {
  return DecoratedBox(
    decoration: BoxDecoration(
        border: Border.all(
          color: ColorUtil.secondaryColor,
        ),
        borderRadius: BorderRadius.circular(2)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            '嗨～～流浪者，定居后就可以构建自己的星球了，现在就去吧...',
          ).withStyle(fontSize: Constants.secondTextSize).paddingAll(8),
        ),
        Gap.makeGap(height: ScreenUtil().setHeight(60)),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: ColorUtil.secondaryColor),
          ),
          child: Text('去定居')
              .withStyle(fontSize: Constants.secondTextSize)
              .paddingSymmetric(horizontal: 25, vertical: 8),
        ).onTap(() {
          NavigatorUtil.push(context, AllGalaxySelectPage().buildPage(null));
        }),
      ],
    ),
  );
}

///搜索框
Widget _buildSearchBar(state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 48,
    padding: EdgeInsets.only(left: 10),
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: ColorUtil.auxiliaryColor,
    ),
    child: TextField(
      enabled: false,
      decoration: InputDecoration(
        hintText: '搜索行星',
        hintStyle: TextStyle(
            color: ColorUtil.secondaryTextColor,
            fontSize: Constants.secondTextSize),
        border: InputBorder.none,
      ),
    ),
  ).onTap(() {
    NavigatorUtil.push(viewService.context, SearchGalaxyPage());
  }).sliverBoxAdapter();
}

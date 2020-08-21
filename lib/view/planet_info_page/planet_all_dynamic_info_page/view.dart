import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/entity/planet_dynamic_list_entity.dart';
import 'package:neng/route/custom_routes.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/dialog_util.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/view/essay_detail_page/page.dart';
import 'package:neng/view/image_preview_page/page.dart';
import 'package:neng/view/planet_info_page/planet_all_dynamic_info_page/action.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'state.dart';

Widget buildView(PlanetAllDynamicInfoState state, Dispatch dispatch,
    ViewService viewService) {
  if (state.listEntity == null) {
    return LoadingView();
  }

  return SmartRefresher(
    enablePullDown: false,
    enablePullUp: state.enableLoadMore,
    physics: const BouncingScrollPhysics(),
    onLoading: () => dispatch(PlanetAllDynamicInfoActionCreator.loadMore()),
    controller: state.refreshController,
    child: ListView.builder(
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
          bottom: 0),
      itemBuilder: (context, index) =>
          _listItem(state, dispatch, context, index),
      itemCount: state.listEntity.rows.length,
    ),
  );
}

Widget _listItem(PlanetAllDynamicInfoState state, Dispatch dispatch,
    BuildContext context, int index) {
  var itemData = state.listEntity.rows[index];

  ///拿到图片集合
  List<String> imgList = _getImgList(itemData);

  ///包括用户头像，姓名，发布时间，评论等的item header
  var headerImage = Row(
    children: <Widget>[
      ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: CachedNetworkImage(
          fadeInDuration: const Duration(milliseconds: 200),
          fit: BoxFit.fitHeight,
          height: 50,
          width: 50,
          imageUrl: '${itemData.headImageUrl}',
          errorWidget: (_, __, ___) => LoadAssetImage(
            'default/default_head',
            height: 50,
            width: 50,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      Gap.makeGap(width: 8),
    ],
  );

  var content = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Gap.makeGap(height: 5),

      Row(
        children: <Widget>[
          ///发布的用户名字
          Text(itemData.nickName ?? "流浪者").withStyle(
              fontSize: Constants.secondTextSize,
              color: ColorUtil.auxiliaryTextColor),
          const Spacer(),

          itemData.userOid == UserProfileUtil.getUserDetailInfo().oid
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                        width: 0.6, color: ColorUtil.auxiliaryTextColor),
                  ),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: ColorUtil.auxiliaryTextColor,
                  ),
                ).onTap(() {
                  DialogUtil.showDialog(
                      context: context,
                      title: '您确定要删除吗？',
                      onConfirm: () {
                        dispatch(PlanetAllDynamicInfoActionCreator.deleteEssay(
                            index));
                        Navigator.pop(context);
                      });
                })
              : Gap.empty,
        ],
      ),
      Gap.makeGap(height: 5),

      ///时间，阅读，评论等
      Row(
        children: <Widget>[
          Text(
            itemData.createTime,
          ).withStyle(
              fontSize: Constants.secondTextSize,
              color: ColorUtil.auxiliaryTextColor),
          const Spacer(),
//          Text('评论2000').withStyle(
//              fontSize: Constants.auxiliaryTextSize,
//              color: ColorUtil.auxiliaryTextColor),
        ],
      ),

      Gap.makeGap(height: 10),

      ///主体文字内容
      Text(
        itemData.content,
        strutStyle: StrutStyle(height: 1.8),
        textAlign: TextAlign.justify,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ).withStyle(
          fontSize: Constants.mainTextSize, color: ColorUtil.mainTextColor),
      Gap.makeGap(height: 15),

      ///图片内容
      imgList.length == 0
          ? Gap.empty
          : GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemCount: imgList.length,
              itemBuilder: (context, index) {
                return _imgGridItem(state, dispatch, context, index, imgList);
              })
    ],
  ).expand();

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      NavigatorUtil.push(
          context, EssayDetailPage().buildPage({'oid': itemData.oid}));
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ///用户头像,用户姓名等上面一排
        headerImage,
        content
      ],
    ).paddingBottom(20),
  );
}

Widget _imgGridItem(PlanetAllDynamicInfoState state, Dispatch dispatch,
    BuildContext context, int index, List<String> imgList) {
  return CachedNetworkImage(
    imageUrl: imgList[index],
    fit: BoxFit.cover,
  ).cornerRadius(4).onTap(() {
    Navigator.push(
      context,
      GradualChangePageRoute(
        ImagePreviewPage(
          imgList: imgList,
          currentIndex: index,
        ),
      ),
    );
  });
}

List<String> _getImgList(PlanetDynamicListRow itemData) {
  List<String> imgList = [];
  if (itemData.imgOne != null) imgList.add(itemData.imgOne);
  if (itemData.imgTwo != null) imgList.add(itemData.imgTwo);
  if (itemData.imgThree != null) imgList.add(itemData.imgThree);
  if (itemData.imgFour != null) imgList.add(itemData.imgFour);
  if (itemData.imgFive != null) imgList.add(itemData.imgFive);
  if (itemData.imgSix != null) imgList.add(itemData.imgSix);
  if (itemData.imgSeven != null) imgList.add(itemData.imgSeven);
  if (itemData.imgEight != null) imgList.add(itemData.imgEight);
  if (itemData.imgNine != null) imgList.add(itemData.imgNine);
  return imgList;
}

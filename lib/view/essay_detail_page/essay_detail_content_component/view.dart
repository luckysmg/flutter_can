import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/entity/essay_detail_entity.dart';
import 'package:neng/route/custom_routes.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/view/image_preview_page/page.dart';

import '../../../widgets/load_asset_image.dart';
import '../state.dart';

Widget buildView(
    EssayDetailState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(state, dispatch, viewService),
          Gap.makeGap(height: 10),
          _buildTextContent(state, dispatch, viewService),
          Gap.makeGap(height: 10),
          _buildImgGrid(state, dispatch, viewService),
          Gap.makeGap(height: 20),
          Gap.line(lPadding: 16, rPadding: 16),
        ],
      ),
    ),
  );
}

Widget _buildHeader(
    EssayDetailState state, Dispatch dispatch, ViewService viewService) {
  return Row(
    children: <Widget>[
      ///头像图片
      SizedBox(
        height: 50,
        width: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: CachedNetworkImage(
            imageUrl: '${state.data.headImageUrl}',
            height: 50,
            width: 50,
            placeholder: (_, __) => LoadAssetImage(
              'default/default_head',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            errorWidget: (_, __, ___) => LoadAssetImage(
              'default/default_head',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),

      Gap.makeGap(width: 10),

      ///名字和日期
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ///名字
          Text(state.data.nickName ?? "流浪者").withStyle(
              fontWeight: FontWeight.w500, fontSize: Constants.mainTextSize),

          Gap.makeGap(height: 10),

          ///日期
          Text(state.data.createTime).withStyle(
              fontSize: Constants.secondTextSize,
              color: ColorUtil.auxiliaryTextColor),
        ],
      )
    ],
  );
}

///文字内容
Widget _buildTextContent(
    EssayDetailState state, Dispatch dispatch, ViewService viewService) {
  return Text(
    state.data.content,
    textAlign: TextAlign.justify,
    strutStyle: StrutStyle(height: 1.8),
  ).withStyle(fontSize: Constants.mainTextSize, color: ColorUtil.mainTextColor);
}

Widget _buildImgGrid(
    EssayDetailState state, Dispatch dispatch, ViewService viewService) {
  List<String> imgList = _getImgList(state.data);

  return imgList.length == 0
      ? Gap.empty
      : GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemCount: imgList.length,
          itemBuilder: (context, index) {
            return _imgGridItem(state, dispatch, context, index, imgList);
          });
}

Widget _imgGridItem(EssayDetailState state, Dispatch dispatch,
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

List<String> _getImgList(EssayDetailEntity data) {
  List<String> imgList = [];
  if (data.imgOne != null) imgList.add(data.imgOne);
  if (data.imgTwo != null) imgList.add(data.imgTwo);
  if (data.imgThree != null) imgList.add(data.imgThree);
  if (data.imgFour != null) imgList.add(data.imgFour);
  if (data.imgFive != null) imgList.add(data.imgFive);
  if (data.imgSix != null) imgList.add(data.imgSix);
  if (data.imgSeven != null) imgList.add(data.imgSeven);
  if (data.imgEight != null) imgList.add(data.imgEight);
  if (data.imgNine != null) imgList.add(data.imgNine);
  return imgList;
}

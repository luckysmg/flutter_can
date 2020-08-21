import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/widgets/load_asset_image.dart';

import '../state.dart';

Widget buildView(
    BookDetailState state, Dispatch dispatch, ViewService viewService) {
  var data = state.bookDetailData.data;

  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ///图片
          SizedBox(
            width: 110,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: CachedNetworkImage(
                imageUrl: data.cover,
                errorWidget: (_, __, ___) => LoadAssetImage(
                  'default/pic_blank_book',
                  width: 110,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),

          Gap.makeGap(width: 10),

          ///右边的内容
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTitleText(data.name),
                _buildText(data.author),
                _buildText(data.publisher),
                _buildText(data.publishDate),
                _buildPriceText('￥${data.price.toString()}'),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget _buildTitleText(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0),
    child: Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          color: ColorUtil.mainTextColor,
          fontSize: Constants.secondTitleTextSize),
      maxLines: 2,
    ),
  );
}

Widget _buildText(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Text(
      text,
      style: TextStyle(
          color: ColorUtil.mainTextColor, fontSize: Constants.mainTextSize),
      maxLines: 2,
    ),
  );
}

Widget _buildPriceText(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0),
    child: Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          color: ColorUtil.redColor,
          fontSize: Constants.mainTextSize),
      maxLines: 1,
    ),
  );
}

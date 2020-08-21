import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/view/essay_detail_page/action.dart';
import 'package:neng/widgets/load_asset_image.dart';

import '../state.dart';

Widget buildView(
    EssayDetailState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Spacer(),
        GestureDetector(
          onTap: () {
            dispatch(EssayDetailActionCreator.like());
          },
          child: Row(
            children: <Widget>[
              LoadAssetImage(
                state.data.likeStatus == 'YES'
                    ? 'ico_praise'
                    : 'ico_praise_empty',
                width: 30,
              ),
              Gap.makeGap(width: 5),
              Text(state.data.likeNumber.toString()).withStyle(
                  fontSize: Constants.auxiliaryTextSize,
                  color: ColorUtil.auxiliaryTextColor),
            ],
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            dispatch(EssayDetailActionCreator.collect());
          },
          child: Row(
            children: <Widget>[
              LoadAssetImage(
                state.data.collectionStatus == 'YES'
                    ? 'ico_collect'
                    : 'ico_collect_empty',
                width: 30,
              ),
              Gap.makeGap(width: 5),
              Text(state.data.collectionNumber.toString()).withStyle(
                  fontSize: Constants.auxiliaryTextSize,
                  color: ColorUtil.auxiliaryTextColor),
            ],
          ),
        ),
        const Spacer(),
      ],
    ),
  );
}

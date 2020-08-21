import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/widgets/custom_html_widget.dart';

import 'state.dart';

Widget buildView(BookDetailIntroductionState state, Dispatch dispatch,
    ViewService viewService) {
  return SliverToBoxAdapter(
      child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Gap.makeGap(height: 20),
        _header(),
        CustomHtmlWidget(
          data: state.bookDetailData.data.introduction,
        ),
      ],
    ),
  ));
}

Widget _header() {
  return Text('简介',
      style: TextStyle(
          fontWeight: FontWeight.w500,
          color: ColorUtil.mainTextColor,
          fontSize: Constants.secondTitleTextSize));
}

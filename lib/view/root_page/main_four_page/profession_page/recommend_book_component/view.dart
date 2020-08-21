import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/book_detail_page/page.dart';
import 'package:neng/view/check_all_pages/all_book_page/page.dart';
import 'package:neng/widgets/load_asset_image.dart';

import '../state.dart';

Widget buildView(
    ProfessionState state, Dispatch dispatch, ViewService viewService) {
  if (state.recommendBookData.total == 0) {
    return Gap.makeSliverGap();
  }
  return SliverToBoxAdapter(
    child: Column(
      children: <Widget>[
        _buildStepperHeader(viewService),
        GridView.builder(
            padding: const EdgeInsets.only(),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.recommendBookData.total,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 3,
                childAspectRatio: 0.68),
            itemBuilder: (context, index) =>
                _item(state, dispatch, context, index)),
        Gap.makeGap(height: 10),
        Gap.makeLineWithThickness(thicknessHeight: 4),
      ],
    ),
  );
}

Widget _item(
    ProfessionState state, Dispatch dispatch, BuildContext context, int index) {
  var itemData = state.recommendBookData.rows[index];
  return GestureDetector(
    onTap: () => NavigatorUtil.push(
        context, BookDetailPage().buildPage({'oid': itemData.oid}),
        rootNavigator: true),
    child: Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          elevation: 1.0,
          child: SizedBox(
            height: ScreenUtil().setWidth(240),
            child: CachedNetworkImage(
              imageUrl: itemData.cover,
              fit: BoxFit.fitWidth,
              placeholder: (_, __) => LoadAssetImage(
                'default/pic_blank_book',
              ),
              errorWidget: (_, __, ___) => LoadAssetImage(
                'default/pic_blank_book',
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            itemData.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: ColorUtil.mainTextColor,
                fontSize: Constants.secondTextSize),
          ),
        )
      ],
    ),
  );
}

Widget _buildStepperHeader(ViewService viewService,
    {bool showCheckAll = true}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            '推荐书籍',
            style: TextStyle(
                color: ColorUtil.mainTextColor,
                fontSize: Constants.secondTitleTextSize,
                fontWeight: FontWeight.w500),
          ),
        ),
        showCheckAll
            ? GestureDetector(
                onTap: () => NavigatorUtil.push(
                    viewService.context, AllBookPage().buildPage(null),
                    rootNavigator: true),
                child: Container(
                  child: Text('查看全部',
                      style: TextStyle(
                          color: ColorUtil.auxiliaryTextColor,
                          fontSize: Constants.auxiliaryTextSize)),
                ))
            : Gap.empty,
      ],
    ),
  );
}

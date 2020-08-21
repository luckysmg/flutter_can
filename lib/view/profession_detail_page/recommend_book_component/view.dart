import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/widgets/load_asset_image.dart';

import '../state.dart';

Widget buildView(
    ProfessionDetailState state, Dispatch dispatch, ViewService viewService) {
  if (state.recommendBookData.total == 0) {
    return Gap.makeSliverGap();
  }
  return SliverToBoxAdapter(
    child: Column(
      children: <Widget>[
        _buildStepperHeader(viewService, () {
          TipUtil.show(context: viewService.context, message: '进入书籍');
        }),
        GridView.builder(
            padding: const EdgeInsets.only(),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.recommendBookData.total,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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

Widget _item(ProfessionDetailState state, Dispatch dispatch,
    BuildContext context, int index) {
  var itemData = state.recommendBookData.rows[index];
  return GestureDetector(
    onTap: () {
      ToastUtil.show('请设置理想职业后看完整内容.');
    },
    child: Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
              //形状
              //修改圆角
              borderRadius: BorderRadius.circular(2)),
          //阴影高度
          elevation: 1.0,
          child: SizedBox(
            height: ScreenUtil().setWidth(220),
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

Widget _buildStepperHeader(ViewService viewService, VoidCallback onTapAll,
    {bool showCheckAll = false}) {
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
                onTap: onTapAll,
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

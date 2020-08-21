import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';

import '../state.dart';

Widget buildView(
    ProfessionDetailState state, Dispatch dispatch, ViewService viewService) {
  if (state.recommendCertificationData.total == 0) {
    return Gap.makeSliverGap();
  }
  return SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          _buildStepperHeader(viewService, () {
            TipUtil.show(context: viewService.context, message: '进入证书');
          }),
          SizedBox(
            height: 100,
            child: EasyRefresh(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, index) =>
                      _item(state, dispatch, context, index)),
            ),
          ),
          Gap.makeGap(height: 10),
        ],
      ),
    ),
  );
}

Widget _item(ProfessionDetailState state, Dispatch dispatch,
    BuildContext context, int index) {
  var itemData = state.recommendCertificationData.rows[index];
  return GestureDetector(
    onTap: () {
      ToastUtil.show('请设置理想职业后看完整内容.');
    },
    child: Card(
      shape: RoundedRectangleBorder(
        //形状
        //修改圆角
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      //阴影高度
      elevation: 0.2,
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        width: 150,
        child: Stack(
          children: <Widget>[
            Text(
              itemData.name,
              style: TextStyle(
                  color: ColorUtil.mainTextColor,
                  fontSize: Constants.mainTextSize),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Positioned(
              bottom: 10,
              child: Text(
                itemData.unified == 'YES' ? '全国统考' : '非全国统考',
                style: TextStyle(
                    color: ColorUtil.auxiliaryTextColor,
                    fontSize: Constants.auxiliaryTextSize),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildStepperHeader(ViewService viewService, VoidCallback onTapAll,
    {bool showCheckAll = false}) {
  return SizedBox(
    height: 45,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            '推荐证书',
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
                  child: Text(
                    '查看全部',
                    style: TextStyle(
                        color: ColorUtil.auxiliaryTextColor,
                        fontSize: Constants.auxiliaryTextSize),
                  ),
                ),
              )
            : Gap.empty,
      ],
    ),
  );
}

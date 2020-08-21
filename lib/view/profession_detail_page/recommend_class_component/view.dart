import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/entity/home_class_list_entity.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/view/profession_detail_page/action.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:jr_extension/jr_extension.dart';

import '../state.dart';

Widget buildView(
    ProfessionDetailState state, Dispatch dispatch, ViewService viewService) {
  ///没有三个都没有数据的时候隐藏全部整块全部内容
  if (state.homeClassListData.data[0].data.length == 0 &&
      state.homeClassListData.data[1].data.length == 0 &&
      state.homeClassListData.data[2].data.length == 0) {
    return _buildRecommendProfessionPart(state, dispatch, viewService)
        .sliverBoxAdapter();
  }
  return SliverToBoxAdapter(
    child: Column(
      children: <Widget>[
        _buildClassPart(state, dispatch, viewService, '入门', 'BASIC',
            onTapAll: () {
          TipUtil.show(context: viewService.context, message: '点击入门全部');
        }),
        _buildClassPart(state, dispatch, viewService, '进阶', 'ADVANCED',
            onTapAll: () {
          TipUtil.show(context: viewService.context, message: '点击进阶全部');
        }),
        _buildClassPart(state, dispatch, viewService, '高级', 'SENIOR',
            onTapAll: () {
          TipUtil.show(context: viewService.context, message: '点击高级全部');
        }),
        Gap.makeGap(height: 10),
        Gap.makeLineWithThickness(thicknessHeight: 4),
        _buildRecommendProfessionPart(state, dispatch, viewService),
        Gap.makeGap(height: 10),
        Gap.makeLineWithThickness(thicknessHeight: 4),
      ],
    ),
  );
}

Widget _buildClassPart(ProfessionDetailState state, Dispatch dispatch,
    ViewService viewService, String headerText, String level,
    {VoidCallback onTapAll}) {
  ///根据level找到对应的list数据
  List<HomeClassListDataData> listData;
  for (int i = 0; i < state.homeClassListData.data.length; i++) {
    if (state.homeClassListData.data[i].level == level) {
      listData = state.homeClassListData.data[i].data;
      break;
    }
  }

  ///如果没有数据，那么隐藏整个部分
  if (listData == null || listData.isEmpty) {
    return Gap.empty;
  }
  return Column(
    children: <Widget>[
      _buildStepperHeader(headerText, viewService, onTapAll),
      _buildGridView(state, dispatch, viewService, listData),
    ],
  );
}

Widget _buildGridView(ProfessionDetailState state, Dispatch dispatch,
    ViewService viewService, List<HomeClassListDataData> listData) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10.0,
      ),
      itemCount: listData.length,
      itemBuilder: (context, index) =>
          _gridItem(listData, dispatch, context, index),
    ),
  );
}

Widget _gridItem(List<HomeClassListDataData> listData, Dispatch dispatch,
    BuildContext context, int index) {
  var itemData = listData[index];
  return GestureDetector(
    onTap: () {
      ToastUtil.show('请设置理想职业后看完整内容.');
    },
    child: SizedBox(
      width: ScreenUtil().setWidth(190),
      child: Card(
        margin: const EdgeInsets.all(1),
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        //阴影高度
        elevation: 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 100),
              imageUrl: itemData.imageUrl,
              errorWidget: (_, __, ___) => LoadAssetImage(
                'default/pic_blank_curriculum',
              ),
            ),
            Gap.makeGap(
              height: ScreenUtil().setHeight(10),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                itemData.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: ColorUtil.mainTextColor,
                    fontSize: Constants.secondTextSize),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _buildStepperHeader(
    String text, ViewService viewService, VoidCallback onTapAll,
    {bool showCheckAll = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              text,
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
    ),
  );
}

///职业推荐部分
Widget _buildRecommendProfessionPart(
    ProfessionDetailState state, Dispatch dispatch, ViewService viewService) {
  var header = Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: SizedBox(
      height: 45,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            '职业推荐',
            style: TextStyle(
                color: ColorUtil.mainTextColor,
                fontSize: Constants.secondTitleTextSize,
                fontWeight: FontWeight.w500),
          )),
        ],
      ),
    ),
  );

  ///是否应该只显示4个item
  bool showFourItem;
  if (state.recommendProfessionData.data.length < 4) {
    showFourItem = false;
  } else {
    showFourItem = !state.expanded;
  }

  return Column(
    children: <Widget>[
      ///头部
      header,

      ///列表

      AnimatedContainer(
        height: showFourItem
            ? 4 * 54 + 10.0
            : state.recommendProfessionData.data.length * 54.0 + 10,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInSine,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12),
            shrinkWrap: true,
            itemCount:
                showFourItem ? 4 : state.recommendProfessionData.data.length,
            itemBuilder: (context, index) =>
                _listItem(state, dispatch, context, index)),
      ),

      ///展开收起按钮
      state.recommendProfessionData.data.length > 4
          ? GestureDetector(
              onTap: () =>
                  dispatch(ProfessionDetailActionCreator.switchExpanded()),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(state.expanded ? '收起' : '展开',
                        style: TextStyle(
                            color: ColorUtil.mainTextColor,
                            fontSize: Constants.auxiliaryTextSize)),
                    Icon(
                      state.expanded
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: ColorUtil.auxiliaryTextColor,
                    ),
                  ],
                ),
              ),
            )
          : Gap.empty,
    ],
  );
}

Widget _listItem(ProfessionDetailState state, Dispatch dispatch,
    BuildContext context, int index) {
  var itemData = state.recommendProfessionData.data[index];
  return Card(
    elevation: 0.2,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      child: Row(
        children: <Widget>[
          Text(itemData.name).withStyle(fontSize: Constants.mainTextSize),
          const Spacer(),
        ],
      ),
    ),
  );
}

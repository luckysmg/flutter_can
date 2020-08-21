import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/view/class_detail_page/introduction_page/action.dart';
import 'package:neng/widgets/custom_html_widget.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/loading_view.dart';

import 'state.dart';

Widget buildView(
    IntroductionState state, Dispatch dispatch, ViewService viewService) {
  if (state.classDetailEntity == null || state.classDictionaryEntity == null) {
    return LoadingView();
  }

  return ListView(
    physics: const BouncingScrollPhysics(),
    children: <Widget>[
      ///标题header部分
      _buildTitle(state, dispatch, viewService),

      Gap.makeGap(height: 10),

      ///目录
      _buildDicData(state, dispatch, viewService),

      ///html控件
      _buildHtmlView(state, dispatch, viewService),

      ///授课机构
      ///_teachingInstitution(state, dispatch, viewService),
    ],
  );
}

///标题header部分
Widget _buildTitle(
    IntroductionState state, Dispatch dispatch, ViewService viewService) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ///标题
        Text(
          state.classDetailEntity.data.title,
          style: TextStyle(
              color: ColorUtil.mainTextColor,
              fontSize: Constants.secondTitleTextSize,
              fontWeight: FontWeight.w500),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),

        Gap.makeGap(height: 5),

        ///课时，所属机构名称
        Row(
          children: <Widget>[
            Text('${state.classDetailEntity.data.periods}课时')
                .withStyle(fontSize: Constants.secondTextSize),
            Gap.makeGap(width: 10),
            Text(state.classDetailEntity.data.commercialName)
                .withStyle(fontSize: Constants.secondTextSize),
          ],
        ),

        Gap.makeGap(height: 5),

        ///价格等
        Row(
          children: <Widget>[
            Text(
              state.classDetailEntity.data.discountPrice == '0.00'
                  ? '免费'
                  : state.classDetailEntity.data.discountPrice,
              style: TextStyle(
                  color: ColorUtil.redColor,
                  fontSize: Constants.mainTextSize,
                  fontWeight: FontWeight.w500),
            ),
            Gap.makeGap(width: 10),
            Text("¥" + state.classDetailEntity.data.price,
                style: Constants.lineThroughTextStyle),
            const Spacer(),

            ///收藏
            Stack(
              children: <Widget>[
                LoadAssetImage(
                  state.classDetailEntity.data.collectionStatus == 'YES'
                      ? 'ico_collect'
                      : 'ico_collect_empty',
                  width: 30,
                ),
                Text(state.classDetailEntity.data.collectionNumber.toString())
                    .withStyle(
                      fontSize: Constants.auxiliaryTextSize,
                    )
                    .offset(offset: Offset(20, -5)),
              ],
            ).onTap(() {
              dispatch(IntroductionActionCreator.collect());
            }).paddingRight(10),
          ],
        ),
      ],
    ),
  );
}

///目录布局
Widget _buildDicData(
    IntroductionState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    color: ColorUtil.auxiliaryColor,
    height: 140,
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "目录",
              style: TextStyle(
                  color: ColorUtil.mainTextColor,
                  fontSize: Constants.secondTitleTextSize,
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Row(
              children: <Widget>[
                Text("全部").withStyle(
                    fontSize: Constants.secondTextSize,
                    color: ColorUtil.secondaryTextColor),
                Gap.makeGap(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  color: ColorUtil.secondaryTextColor,
                  size: 16,
                ),
                Gap.makeGap(width: 16),
              ],
            ).paddingBottom(5).onTap(() {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: viewService.context,
                  builder: (context) {
                    return _PopDicView(
                      state: state,
                      dispatch: dispatch,
                      viewService: viewService,
                    );
                  });
            }),
          ],
        ).padding(left: 16, bottom: 10, top: 5),
        SizedBox(
          height: 80,
          child: EasyRefresh(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: state.classDictionaryEntity.data.length,
              itemBuilder: (BuildContext context, int index) =>
                  _dicItem(state, dispatch, context, index),
            ),
          ),
        ),
      ],
    ),
  );
}

///目录里面一个item的布局
Widget _dicItem(IntroductionState state, Dispatch dispatch,
    BuildContext context, int index) {
  var itemData = state.classDictionaryEntity.data[index];
  var isCurrent =
      state.currentUrl == state.classDictionaryEntity.data[index].videoUrl;
  return Card(
    elevation: 1,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      width: 140,
      child: Text('${index + 1}.${itemData.title}',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: Constants.secondTextSize,
              color: isCurrent ? ColorUtil.mainColor : null)),
    ),
  ).padding(left: 16).onTap(() {
    dispatch(IntroductionActionCreator.changeUrl(
        state.classDictionaryEntity.data[index].videoUrl));
  });
}

///富文本布局
Widget _buildHtmlView(
    IntroductionState state, Dispatch dispatch, ViewService viewService) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: <Widget>[
        CustomHtmlWidget(
          data: state.classDetailEntity.data.context,
        ),
        Gap.makeLineWithThickness(),
      ],
    ),
  );
}

///授课机构布局
//Widget _teachingInstitution(
//    IntroductionState state, Dispatch dispatch, ViewService viewService) {
//  return Padding(
//    padding: EdgeInsets.symmetric(horizontal: 16),
//    child: Row(
//      children: <Widget>[
//        Expanded(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Gap.makeGap(height: 10),
//              Text('授课机构',
//                  style: TextStyle(
//                      color: ColorUtil.mainTextColor,
//                      fontSize: Constants.secondTitleTextSize)),
//              Gap.makeGap(height: 10),
//              Row(
//                children: <Widget>[
//                  ///授课机构的图片
//                  SizedBox(
//                    height: 40,
//                    width: 40,
//                    child: ClipRRect(
//                      borderRadius: BorderRadius.circular(8),
//                      child: CachedNetworkImage(
//                        imageUrl: state.classDetailEntity.data.imageUrl,
//                        fit: BoxFit.fitHeight,
//                      ),
//                    ),
//                  ),
//
//                  Gap.makeGap(width: 10),
//                  Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text(state.classDetailEntity.data.commercialName,
//                          style: TextStyle(
//                              color: ColorUtil.mainTextColor,
//                              fontSize: Constants.mainTextSize)),
//                      Gap.makeGap(height: 5),
//                      Text('课程数量30',
//                          style: TextStyle(
//                              color: ColorUtil.auxiliaryTextColor,
//                              fontSize: Constants.secondTextSize)),
//                    ],
//                  )
//                ],
//              ),
//            ],
//          ),
//        ),
//      ],
//    ),
//  );
//}

class _PopDicView extends StatefulWidget {
  final IntroductionState state;
  final Dispatch dispatch;
  final ViewService viewService;

  const _PopDicView({Key key, this.state, this.dispatch, this.viewService})
      : super(key: key);

  @override
  _PopDicViewState createState() => _PopDicViewState();
}

class _PopDicViewState extends State<_PopDicView> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        200 -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      height: height,
      color: ColorUtil.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ///header
          Row(
            children: <Widget>[
              Text("目录",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Constants.secondTitleTextSize)),
              const Spacer(),
              Icon(
                Icons.close,
                size: 30,
              ).onTap(() => Navigator.pop(context)),
            ],
          ),
          Gap.makeGap(height: 10),

          ///目录网格列表
          GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2, mainAxisSpacing: 10),
              itemCount: widget.state.classDictionaryEntity.data.length,
              itemBuilder: (context, index) {
                return SizedBox(height: 100, child: _buildItem(index));
              }),
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    var itemData = widget.state.classDictionaryEntity.data[index];
    var isCurrent = widget.state.currentUrl ==
        widget.state.classDictionaryEntity.data[index].videoUrl;
    return Card(
      child: Container(
        //width: 300,
        padding: const EdgeInsets.all(8.0),
        child: Text('$index.${itemData.title}',
            style: TextStyle(
                fontSize: Constants.secondTextSize,
                fontWeight: isCurrent ? FontWeight.w500 : null,
                color: isCurrent ? ColorUtil.mainColor : null)),
      ),
    ).onTap(() {
      widget.dispatch(IntroductionActionCreator.changeUrl(
          widget.state.classDictionaryEntity.data[index].videoUrl));
      setState(() {});
    });
  }
}

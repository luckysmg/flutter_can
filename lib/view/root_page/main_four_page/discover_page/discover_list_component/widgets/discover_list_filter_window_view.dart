import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/entity/profession_list_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/widgets/empty_view.dart';
import 'package:neng/widgets/horizontal_circle_button.dart';
import 'package:neng/widgets/loading_view.dart';

class DiscoverListFilterWindowView extends StatefulWidget {
  @override
  _DiscoverListFilterWindowViewState createState() =>
      _DiscoverListFilterWindowViewState();
}

class _DiscoverListFilterWindowViewState
    extends State<DiscoverListFilterWindowView> {
  ProfessionListEntity professionListData;
  int currentIndex;
  ScrollController scrollController;
  int selectedCount;

  List<String> selectedIdList;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    selectedCount = 0;
    selectedIdList = List();
    scrollController = ScrollController();
    DioUtil.getInstance().doPost<ProfessionListEntity>(
        url: API.profession_list,
        context: context,
        onSuccess: (data) {
          professionListData = data;
          professionListData.data.forEach((item) {
            item.children.forEach((childItem) {
              childItem.isSelected = false;
            });
          });
          setState(() {});
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }

  @override
  Widget build(BuildContext context) {
    if (professionListData == null) {
      return SizedBox(
        height: 370,
        child: LoadingView(
          topDistance: 200,
        ),
      );
    }

    var emptyView = const EmptyView();

    var leftList = Container(
      color: Colors.grey[200],
      width: 120,
      child: EasyRefresh(
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 40),
          shrinkWrap: true,
          itemCount: professionListData.data.length,
          itemBuilder: (context, index) => _leftItem(context, index),
        ),
      ),
    );

    var rightList = Expanded(
      child: EasyRefresh.custom(
        scrollController: scrollController,
        slivers: <Widget>[
          professionListData.data[currentIndex].children.length == 0
              ? emptyView
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => _rightItem(context, index),
                      childCount: professionListData
                          .data[currentIndex].children.length),
                )
        ],
      ),
    );

    return Container(
      width: ScreenUtil.screenWidthDp,
      height: 370,
      color: Colors.white54,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 300,
            child: Row(
              children: <Widget>[
                leftList,
                rightList,
              ],
            ),
          ),
          Gap.makeGap(height: 10),
          _twoButtons(),
        ],
      ),
    );
  }

  Widget _twoButtons() {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: HorizontalCircleButton(
                width: 130,
                horizontalPadding: 0,
                color: ColorUtil.mainColor,
                onTap: () {
                  selectedIdList.clear();
                  professionListData.data.forEach((item) {
                    item.children.forEach((childItem) {
                      childItem.isSelected = false;
                    });
                  });
                  setState(() {});
                },
                child: Text(
                  '重 置',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(32)),
                ),
              ),
            ),
            Gap.makeGap(width: 20),
            Expanded(
              child: HorizontalCircleButton(
                onTap: () => Navigator.pop(context, selectedIdList),
                width: 130,
                horizontalPadding: 0,
                color: ColorUtil.mainColor,
                child: Text(
                  '确 定(${selectedIdList.length}/5)',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(32)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _leftItem(BuildContext context, int index) {
    var itemData = professionListData.data[index];
    Color textColor =
        index == currentIndex ? ColorUtil.mainColor : Colors.black;
    return GestureDetector(
      onTap: () {
        if (currentIndex != index) {
          currentIndex = index;
          scrollController.jumpTo(0);
          setState(() {});
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: currentIndex == index ? Colors.white : null,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(itemData.name,
              style: TextStyle(
                  color: textColor,
                  fontSize: ScreenUtil().setSp(28),
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }

  Widget _rightItem(BuildContext context, index) {
    var itemData = professionListData.data[currentIndex].children[index];
    return GestureDetector(
      onTap: () {
        if (selectedIdList.length == 5 && !itemData.isSelected) {
          TipUtil.showWaring(context: context, message: '最多只能选选择5个职业');
          return;
        }
        if (!itemData.isSelected) {
          selectedIdList.add(itemData.oid);
        } else {
          selectedIdList.remove(itemData.oid);
        }
        itemData.isSelected = !itemData.isSelected;
        setState(() {});
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: ColorUtil.auxiliaryColor, width: 0.6),
        )),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15.7),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  itemData.name,
                  style: TextStyle(fontSize: ScreenUtil().setSp(28)),
                ),
              ),
              itemData.isSelected ?? false
                  ? Icon(
                      Icons.book,
                      size: ScreenUtil().setSp(30),
                    )
                  : Gap.empty,
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/entity/search_galaxy_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/planet_info_page/page.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/empty_view.dart';
import 'package:neng/widgets/load_asset_image.dart';

class SearchGalaxyPage extends StatefulWidget {
  @override
  _SearchGalaxyPageState createState() => _SearchGalaxyPageState();
}

class _SearchGalaxyPageState extends State<SearchGalaxyPage> {
  TextEditingController textEditingController;
  SearchGalaxyEntity data;
  FocusNode focusNode;

  void requestData() async {
    DioUtil.getInstance().doPost<SearchGalaxyEntity>(
        url: API.search_planet,
        context: context,
        param: {
          'title': textEditingController.text ?? '',
          'page': 1,
          'size': 15,
        },
        onSuccess: (data) {
          this.data = data;
          setState(() {});
        });
  }

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavigationBar(
        title: "搜索行星",
      ),
      body: EasyRefresh(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            _buildInputBox(),
            _buildSearchContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchContent() {
    if (data == null) {
      return Gap.empty;
    }
    if (data.rows.length == 0) {
      return EmptyView(
        title: "没有结果",
      );
    }

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: data.rows.length,
        itemBuilder: (context, index) => item(context, index));
  }

  Widget _buildInputBox() {
    return Row(
      children: <Widget>[
        _buildTextField(),
        CupertinoButton(
            minSize: 0,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
            color: ColorUtil.mainColor,
            borderRadius: BorderRadius.circular(4),
            child: Text(
              '搜索',
              style: TextStyle(fontSize: Constants.mainTextSize),
            ),
            onPressed: () => requestData()),
        Gap.makeGap(width: 10),
      ],
    );
  }

  Widget item(BuildContext context, int index) {
    var itemData = data.rows[index];
    return Row(
      children: <Widget>[
        itemData.img == "NONE"
            ? LoadAssetImage(
                'default/pic_blank_planet',
                height: ScreenUtil().setHeight(100),
                width: ScreenUtil().setHeight(100),
                fit: BoxFit.cover,
              )
            : SizedBox(
                height: ScreenUtil().setHeight(100),
                width: ScreenUtil().setHeight(100),
                child: CachedNetworkImage(
                  fadeInDuration: const Duration(milliseconds: 200),
                  imageUrl: itemData.img,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => LoadAssetImage(
                    'default/pic_blank_planet',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
        Gap.makeGap(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(itemData.title).withStyle(
                fontWeight: FontWeight.w500, fontSize: Constants.mainTextSize),
            Gap.makeGap(height: 5),
            Row(
              children: <Widget>[
                Text(itemData.nickName ?? "流浪者")
                    .withStyle(fontSize: Constants.secondTextSize),
                Gap.makeGap(width: 5),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: ColorUtil.secondaryColor),
                  child: Text('星主').withStyle(
                      color: ColorUtil.mainTextColor,
                      fontSize: Constants.auxiliaryTextSize),
                ),
              ],
            ),
            //Gap.makeGap(height: 10),
            Gap.line(),
          ],
        )
      ],
    ).paddingSymmetric(vertical: 5).onTap(() {
      NavigatorUtil.push(
          context,
          PlanetInfoPage().buildPage({
            'oid': itemData.oid,
            'galaxyOwnerName': itemData.nickName ?? "流浪者",
          }));
    }, hitTestBehavior: HitTestBehavior.opaque);
  }

  Widget _buildTextField() {
    return Expanded(
      child: Container(
        height: 48,
        padding: EdgeInsets.only(left: 10),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: ColorUtil.auxiliaryColor,
        ),
        child: TextField(
          focusNode: focusNode,
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: '搜索行星',
            hintStyle: TextStyle(
                color: ColorUtil.secondaryTextColor,
                fontSize: Constants.secondTextSize),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

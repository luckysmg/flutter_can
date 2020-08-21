import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/entity/search_profession_entity.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/entity/user_profile_entity.dart';
import 'package:neng/event/user_info_change_event.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/store/global_store.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/view/profession_detail_page/page.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';

///
/// @created by 文景睿
/// description:搜索职业的页面
///
class SearchProfessionPage extends StatefulWidget {
  final bool isFromSettingPage;

  const SearchProfessionPage({Key key, this.isFromSettingPage = true})
      : super(key: key);

  @override
  _SearchProfessionPageState createState() => _SearchProfessionPageState();
}

class _SearchProfessionPageState extends State<SearchProfessionPage> {
  FocusNode focusNode;
  SearchProfessionEntity searchProfessionData;
  String text;
  String professionName;
  String professionCode;

  void requestData() {
    DioUtil.getInstance().doPost<SearchProfessionEntity>(
        url: API.search_profession_by_name,
        context: context,
        param: {'page': 1, "size": 15, 'name': text},
        onSuccess: (data) {
          searchProfessionData = data;
          setState(() {});
        },
        onFailure: (e) {});
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    Future.delayed(Duration(milliseconds: 300), () {
      focusNode.requestFocus();
      requestData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavigationBar(title: '搜索职业'),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Gap.makeGap(height: 10),
          _buildInputBox(),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: searchProfessionData?.rows?.length ?? 0,
            itemBuilder: (context, index) => _item(context, index),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBox() {
    return Material(
      child: Container(
        height: 48,
        padding: EdgeInsets.only(left: 10),
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: ColorUtil.auxiliaryColor,
        ),
        child: TextField(
          onChanged: (text) {
            this.text = text;
            requestData();
          },
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: '搜索你感兴趣的职业',
            //contentPadding: EdgeInsets.only(bottom: 10),
            hintStyle: TextStyle(
                color: ColorUtil.secondaryTextColor,
                fontSize: Constants.secondTextSize),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _item(BuildContext context, int index) {
    var itemData = searchProfessionData.rows[index];
    return GestureDetector(
      onTap: () {
        professionName = itemData.name;
        professionCode = itemData.oid;

        ///如果不是从设置页过来的，那么就跳转详情页，否则进入选择职业的流程
        if (!widget.isFromSettingPage) {
          NavigatorUtil.push(
              context,
              ProfessionDetailPage().buildPage(
                  {'oid': professionCode, 'professionName': professionName}));
          return;
        }
        showCupertinoDialog(
          context: context,
          builder: (context) => _buildDialogView(context),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: ColorUtil.auxiliaryColor, width: 0.6),
        )),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21, vertical: 15.7),
          child: Text(
            itemData.name,
            style: TextStyle(
                fontSize: Constants.secondTextSize,
                color: ColorUtil.mainTextColor),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogView(BuildContext context) {
    return Center(
      child: Material(
        child: Container(
          height: ScreenUtil().setHeight(230),
          width: ScreenUtil.screenWidthDp * 0.72,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(150),
                child: Text(
                  '确定将$professionName设定为理想职业？',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: Constants.mainTextSize,
                      color: ColorUtil.mainTextColor),
                ),
              ),

              ///下面的按钮
              Container(
                height: ScreenUtil().setHeight(80),
                decoration: BoxDecoration(
                  border: Border(
                    top:
                        BorderSide(color: ColorUtil.auxiliaryColor, width: 0.6),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(20),
                            horizontal: ScreenUtil().setWidth(90)),
                        minSize: ScreenUtil().setHeight(20),
                        pressedOpacity: 0.4,
                        child: Text('取消',
                            style: TextStyle(
                                fontSize: Constants.secondTitleTextSize,
                                color: ColorUtil.auxiliaryTextColor)),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    CupertinoButton(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(20),
                            horizontal: ScreenUtil().setWidth(90)),
                        minSize: ScreenUtil().setHeight(20),
                        pressedOpacity: 0.4,
                        child: Text('确定',
                            style: TextStyle(
                                fontSize: Constants.secondTitleTextSize,
                                color: ColorUtil.mainColor)),
                        onPressed: () async {
                          ///确定选择职业
                          ///确定选择职业
                          DioUtil.getInstance().doPost<SimpleEntity>(
                              url: API.save_profession,
                              param: {
                                'professionName': professionName,
                                'professionCode': professionCode,
                              },
                              context: context,
                              onSuccess: (data) async {
                                UserProfileEntity entity =
                                    UserProfileUtil.getUserDetailInfo();
                                entity.professionName = professionName;
                                entity.professionCode = professionCode;
                                await UserProfileUtil.setUserDetailInfo(entity);
                                GlobalStore.getEventBus()
                                    .fire(UserInfoChangeEvent());
                                Navigator.pop(context);
                                Navigator.pop(context, true);
                              },
                              onFailure: (e) {
                                ToastUtil.show(e.msg);
                              });
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

//    return Center(
//      child: Material(
//        borderRadius: BorderRadius.circular(10),
//        child: Container(
//          height: 160,
//          width: 300,
//          decoration: BoxDecoration(
//              color: Colors.white, borderRadius: BorderRadius.circular(10)),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
//                margin: EdgeInsets.only(
//                    bottom: ScreenUtil().setHeight(40),
//                    top: ScreenUtil().setHeight(20)),
//                child: Text(
//                  '您确定要将$professionName设定为您的理想职业么？',
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                      fontSize: ScreenUtil().setSp(35), color: Colors.black45),
//                ),
//              ),
//
//              ///下面的按钮
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Container(
//                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
//                    child: CupertinoButton(
//                        color: Colors.grey,
//                        padding: EdgeInsets.symmetric(
//                            vertical: ScreenUtil().setHeight(10),
//                            horizontal: ScreenUtil().setWidth(40)),
//                        minSize: ScreenUtil().setHeight(30),
//                        pressedOpacity: 0.4,
//                        child:
//                            Text('取消', style: TextStyle(color: Colors.white)),
//                        onPressed: () {
//                          Navigator.pop(context);
//                        }),
//                  ),
//                  Container(
//                    child: CupertinoButton(
//                        color: Constants.mainColor,
//                        padding: EdgeInsets.symmetric(
//                            vertical: ScreenUtil().setHeight(10),
//                            horizontal: ScreenUtil().setWidth(40)),
//                        minSize: ScreenUtil().setHeight(30),
//                        pressedOpacity: 0.4,
//                        child:
//                            Text('确定', style: TextStyle(color: Colors.white)),
//                        onPressed: () async {
//                          ///确定选择职业
//                          DioUtil.getInstance().doPost<SimpleEntity>(
//                              url: API.save_profession,
//                              param: {
//                                'professionName': professionName,
//                                'professionCode': professionCode,
//                              },
//                              context: context,
//                              onSuccess: (data) async {
//                                UserProfileEntity entity =
//                                    UserProfileUtil.getUserDetailInfo();
//                                entity.professionName = professionName;
//                                entity.professionCode = professionCode;
//                                await UserProfileUtil.setUserDetailInfo(entity);
//                                GlobalStore.getEventBus()
//                                    .fire(UserInfoChangeEvent());
//                                Navigator.pop(context);
//                                Navigator.pop(context, true);
//                              },
//                              onFailure: (e) {
//                                TipUtil.showWaring(
//                                    context: context, message: e.msg);
//                              });
//                        }),
//                  )
//                ],
//              )
//            ],
//          ),
//        ),
//      ),
//    );
  }
}

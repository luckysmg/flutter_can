import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/view/user/edit_info_page/page.dart';
import 'package:neng/widgets/load_asset_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  ///头像url
  var headImgUrl = UserProfileUtil.getUserDetailInfo().headImageUrl;

  ///是否应该显示真的头像
  bool canShowRealHeadImg =
      UserProfileUtil.isUserLogin() && (headImgUrl != null);

  ///显示工作
  var professionName;
  if (!UserProfileUtil.isUserLogin()) {
    professionName = '去登录/注册';
  } else if (UserProfileUtil.getUserDetailInfo().professionName == null) {
    professionName = '未设置';
  } else {
    professionName = UserProfileUtil.getUserDetailInfo().professionName;
  }

  return Column(
    children: <Widget>[
      //Gap.makeGap(height: 10),
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          dispatch(HeaderActionCreator.prepareJumpPage());
        },
        child: Container(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Gap.makeGap(width: 20),
              Container(
                child: Row(
                  children: <Widget>[
                    ///头像
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: canShowRealHeadImg
                          ? CachedNetworkImage(
                              fadeInDuration: const Duration(milliseconds: 200),
                              imageUrl: headImgUrl,
                              width: 100,
                              height: 100,
                              placeholder: (_, __) => LoadAssetImage(
                                'default/default_head',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (_, __, ___) => LoadAssetImage(
                                  'default/default_head',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover),
                            )
                          : LoadAssetImage('default/default_head',
                              width: 100, height: 100, fit: BoxFit.cover),
                    ),

                    Gap.makeGap(
                      width: 20,
                    ),

                    ///头像右边的信息
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ///名字
                          Text(
                            UserProfileUtil.isUserLogin()
                                ? UserProfileUtil.getUserDetailInfo()
                                        .nickName ??
                                    '未设置'
                                : '未登录',
                            style: TextStyle(
                                fontSize: Constants.titleTextSize,
                                fontWeight: FontWeight.w500),
                          ),

                          Gap.makeGap(height: 10),
                          Container(
                            child: Text(
                              professionName,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: Constants.secondTextSize,
                                  color: ColorUtil.secondaryTextColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      UserProfileUtil.isUserLogin()
          ? Container(
              height: 30,
              padding: EdgeInsets.only(right: 16),
              child: Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border:
                        Border.all(color: ColorUtil.mainTextColor, width: 0.5),
                  ),
                  height: 30,
                  width: 80,
                  child: Center(
                    child: Text("编辑资料").withStyle(
                        color: ColorUtil.mainTextColor,
                        fontSize: Constants.secondTextSize),
                  ).onTap(() {
                    if (UserProfileUtil.isUserLogin()) {
                      NavigatorUtil.push(
                          viewService.context, EditInfoPage().buildPage(null),
                          rootNavigator: true);
                      return;
                    } else {
                      dispatch(HeaderActionCreator.prepareJumpPage());
                    }
                    //UserProfileUtil.pushLoginPage(context);
                  }),
                ),
              ))
          : Gap.empty,
    ],
  );
}

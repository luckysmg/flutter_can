import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/dialog_util.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/widgets/bottom_bar.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/horizontal_circle_button.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../util/navigatior_util.dart';
import '../../util/user_profile_util.dart';
import '../login/password_login_page/page.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    ProfessionDetailState state, Dispatch dispatch, ViewService viewService) {
  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else if (state.homeClassListData == null) {
    body = LoadingView();
  } else {
    body = SmartRefresher(
      onRefresh: () => dispatch(LifecycleCreator.initState()),
      physics: BouncingScrollPhysics(),
      controller: state.refreshController,
      child: CustomScrollView(
        slivers: <Widget>[
          Gap.makeSliverGap(height: 10),

          ///入门-进阶-高级-职业推荐
          viewService.buildComponent('recommendClassList'),

          ///推荐书籍
          viewService.buildComponent('recommendBookList'),

          ///推荐证书
          viewService.buildComponent('recommendCertificationList'),
        ],
      ),
    );
  }
  return Scaffold(
    bottomNavigationBar: _buildBottomBar(state, dispatch, viewService),
    appBar: CustomNavigationBar(
      title: state.professionName,
      trailing: _buildTrailing(state, dispatch, viewService),
    ),
    body: body,
  );
}

Widget _buildTrailing(
    ProfessionDetailState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () {
      TipUtil.show(context: viewService.context, message: '点击了');
    },
    child: Icon(
      Icons.blur_on,
      size: 24,
    ),

//    LoadAssetImage(
//      'ic_detail',
//      width: 22,
//    ),
  );
}

///底部的按钮
Widget _buildBottomBar(
    ProfessionDetailState state, Dispatch dispatch, ViewService viewService) {
  return BottomBar(
    child: HorizontalCircleButton(
      horizontalPadding: 0.0,
      verticalPadding: 0.0,
      radius: 0.0,
      onTap: () {
        if (UserProfileUtil.isUserLogin()) {
          DialogUtil.showDialog(
            dialogHeight: ScreenUtil().setHeight(250),
            context: viewService.context,
            title: '确定将${state.professionName}设定为理想职业?',
            onCancel: () => Navigator.pop(viewService.context),
            onConfirm: () => dispatch(
                ProfessionDetailActionCreator.selectProfession({
              'professionName': state.professionName,
              'professionCode': state.professionOid
            })),
          );
        } else {
          NavigatorUtil.push(viewService.context, LoginPage().buildPage({}),
              rootNavigator: true);
        }
      },
      child: Text('设置为理想职业',
          style: TextStyle(
              color: ColorUtil.darkBackTextColor,
              fontSize: Constants.mainTextSize)),
    ),
  );
}

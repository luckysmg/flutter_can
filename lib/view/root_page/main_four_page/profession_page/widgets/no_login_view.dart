import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/login/password_login_page/page.dart';
import 'package:neng/view/login/widgets/login_button.dart';
import 'package:neng/widgets/load_asset_image.dart';

///
/// @created by 文景睿
/// description:返回没有登陆时的布局
///
class NoLoginView extends StatefulWidget {
  @override
  _NoLoginViewState createState() => _NoLoginViewState();
}

class _NoLoginViewState extends State<NoLoginView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoadAssetImage(
          'default/pic_blank_login',
          height: 150,
        ),
        Gap.makeGap(height: 100),
        Text('请登录后查看').withStyle(fontSize: Constants.mainTextSize),
        Gap.makeGap(height: 20),
        LoginButton(
          feedBack: false,
          onTap: () {
            NavigatorUtil.push(context, LoginPage().buildPage({}),
                rootNavigator: true);
          },
        ),
      ],
    ).center();
  }
}

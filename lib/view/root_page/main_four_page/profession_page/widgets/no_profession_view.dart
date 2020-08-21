import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/select_profession_page/page.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/widgets/load_asset_image.dart';

class NoProfessionView extends StatefulWidget {
  @override
  _NoProfessionViewState createState() => _NoProfessionViewState();
}

class _NoProfessionViewState extends State<NoProfessionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoadAssetImage(
          'default/pic_blank_login',
          width: 150,
        ),
        Gap.makeGap(height: 100),
        Text('你还没有设置你的职业信息').withStyle(fontSize: Constants.mainTextSize),
        Gap.makeGap(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: ColorUtil.mainTextColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text("选择职业").withStyle(fontSize: Constants.secondTextSize),
        ).onTap(() {
          NavigatorUtil.push(context,
              SelectProfessionPage().buildPage({'isfromSettingPage': false}),
              rootNavigator: true);
        }),
      ],
    ).center();
  }
}

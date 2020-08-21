import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/entity/check_planet_in_galaxy_entity.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/util/user_profile_util.dart';
import 'package:neng/view/check_all_pages/all_galaxy_page/page.dart';
import 'package:neng/view/check_all_pages/all_planet_page/page.dart';
import 'package:neng/widgets/load_asset_image.dart';

import '../state.dart';

Widget buildView(
    DiscoverState state, Dispatch dispatch, ViewService viewService) {
  bool hasSettled = UserProfileUtil.isUserLogin() &&
      UserProfileUtil.getUserDetailInfo().galaxyCode != null;

  return Stack(
    alignment: Alignment.bottomCenter,
    children: <Widget>[
      Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          LoadAssetImage(
            'ico_discover_bg',
            fit: BoxFit.contain,
          ),
          hasSettled
              ? _buildSettledContent(state, dispatch, viewService)
              : _buildNoSettledContent(state, dispatch, viewService),
        ],
      ),

      ///圆角
      Container(
        height: 20,
        decoration: BoxDecoration(
          color: Theme.of(viewService.context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        ),

        ///这里添加offset是为了避免锯齿
      ).offset(
        offset: Offset(0, 2),
      ),
    ],
  ).sliverBoxAdapter();
}

///定居布局
Widget _buildSettledContent(
    DiscoverState state, Dispatch dispatch, ViewService viewService) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(UserProfileUtil.getUserDetailInfo().galaxyName).withStyle(
            fontWeight: FontWeight.w500,
            color: ColorUtil.darkBackTextColor,
            fontSize: Constants.titleTextSize),
        Gap.makeGap(height: 10),
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 0.6, color: Colors.white),
              ),
              child: Row(
                children: <Widget>[
                  _RepeatStackImageView(
                    data: state.planetInGalaxyListData,
                  ),
                  Gap.makeGap(width: 15),
                  Text('${state.planetInGalaxyListData.total} 颗行星').withStyle(
                      fontSize: Constants.auxiliaryTextSize,
                      color: Colors.white),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.white,
                  ),
                ],
              ),
            ).onTap(() {
              NavigatorUtil.push(
                  viewService.context, AllPlanetPage().buildPage(null),
                  rootNavigator: true);
            }),
            const Spacer(),

            ///去移民的按钮
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: Colors.white, width: 0.5),
              ),
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Gap.makeGap(width: 10),
                  Text("去移民").withStyle(
                      color: ColorUtil.darkBackTextColor,
                      fontSize: Constants.secondTextSize),
                  Gap.makeGap(width: 10),
                ],
              ).onTap(() {
                NavigatorUtil.push(
                    viewService.context, AllGalaxyPage().buildPage(null),
                    rootNavigator: true);
              }),
            ),
          ],
        )
      ]).paddingSymmetric(horizontal: 20).paddingBottom(30);
}

///未定居布局
Widget _buildNoSettledContent(
    state, Dispatch dispatch, ViewService viewService) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("发现星系").withStyle(
          fontSize: Constants.titleTextSize,
          fontWeight: FontWeight.w500,
          color: ColorUtil.darkBackTextColor),
      Gap.makeGap(height: 10),
      Text("进入你的专属星系，我们需要你").withStyle(
          color: ColorUtil.darkBackTextColor, fontSize: Constants.mainTextSize),
    ],
  ).paddingLeft(20).paddingBottom(30);
}

///重叠的图片
class _RepeatStackImageView extends StatelessWidget {
  final CheckPlanetInGalaxyEntity data;

  const _RepeatStackImageView({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var result;

    List<Widget> widgetList = [];
    widgetList = List.generate(data.rows.length, (i) {
      Widget img;
      if (data.rows[i].img == 'NONE') {
        img = ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: LoadAssetImage(
            'default/pic_blank_planet',
            width: 30,
            height: 30,
            fit: BoxFit.cover,
          ),
        ).offset(offset: Offset((15 * i).toDouble(), 0));
      } else {
        img = ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: CachedNetworkImage(
            imageUrl: data.rows[i].img,
            height: 30,
            width: 30,
            fit: BoxFit.cover,
            placeholder: (_, __) => LoadAssetImage(
              'default/pic_blank_planet',
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
            errorWidget: (_, __, ___) => LoadAssetImage(
                'default/pic_blank_planet',
                width: 30,
                height: 30,
                fit: BoxFit.cover),
          ),
        ).offset(offset: Offset((15 * i).toDouble(), 0));
      }
      return img;
    });

    result = SizedBox(
      height: 30,
      width: data.rows.length == 1 ? 30 : data.rows.length * 18.0,
      child: Stack(
        children: widgetList,
      ),
    );

    return result;
  }
}

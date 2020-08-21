import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/entity/release_version_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/dialog_ota_update_util.dart';
import 'package:neng/util/dialog_util.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info/package_info.dart';

import '../../../util/constants.dart';

///
/// @created by 文景睿
/// description:关于我们
///
class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  var _version = '';
  String progress = '';

  @override
  void initState() {
    super.initState();
    getLocalVersion();
  }

  void getLocalVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    setState(() {
      _version = Platform.isIOS ? '$version' : '$version';
    });
  }

  void getVersion() async {
    if (Platform.isAndroid) {
      DioUtil.getInstance().doPost<ReleaseVersionEntity>(
          url: API.get_android_version,
          context: context,
          onSuccess: (data) {
            if (_version != data.versions) {
              DialogOtaUpdateUtil.showDialog(
                  dialogHeight: ScreenUtil().setHeight(280),
                  context: context,
                  title: '有新版本,是否直接升级.',
                  onConfirm: () {
                    String downloadLink = data.downloadLink;
                    try {
                      OtaUpdate()
                          .execute(downloadLink,
                              destinationFilename:
                                  'planet_${data.versions}.apk')
                          .listen(
                        (OtaEvent event) {
                          //print('EVENT: ${event.status} : ${event.value}');
                        },
                      );
                    } catch (e) {
                      print('更新失败，请稍后再试');
                    }
                  },
                  onCancel: () => Navigator.pop(context));
            } else {
              ToastUtil.show("已经是最新版本了.");
            }
          },
          onFailure: (e) {
            //ToastUtil.show(e.msg);
          });
    } else {
      DioUtil.getInstance().doPost<ReleaseVersionEntity>(
          url: API.get_ios_version,
          context: context,
          onSuccess: (data) {
            if (_version != data.versions) {
              //TODO 跳转市场
            }
          },
          onFailure: (e) {
            //ToastUtil.show(e.msg);
          });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavigationBar(
        title: '关于我们',
      ),
      body: ListView(
        children: <Widget>[
          _header(),
          Gap.makeGap(height: 50),
          Gap.line(lPadding: 16),
          _item('功能介绍', () {
            TipUtil.show(context: context, message: '功能介绍');
          }),
          Gap.line(lPadding: 16),
          _item('版本更新', () {
            getVersion();
          }),
          Gap.line(lPadding: 16),
        ],
      ),
    );
  }

  ///主图和文字和版本
  Widget _header() {
    return Container(
      child: Column(
        children: <Widget>[
          Gap.makeGap(height: 60),
          LoadAssetImage(
            'logo',
            height: 60,
          ),
          Gap.makeGap(height: 10),
          Text('星球BOOM',
              style: TextStyle(
                  color: ColorUtil.mainTextColor,
                  fontSize: Constants.titleTextSize)),
          Gap.makeGap(height: 5),
          Text('版本 ' + _version,
              style: TextStyle(
                  color: ColorUtil.mainTextColor,
                  fontSize: Constants.mainTextSize)),
        ],
      ),
    );
  }

  Widget _buildArrow() {
    return Icon(
      Icons.keyboard_arrow_right,
      size: 20,
      color: ColorUtil.mainTextColor,
    );
  }

  Widget _item(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 0.0, 16.0, 0.0),
        constraints:
            BoxConstraints(maxHeight: double.infinity, minHeight: 50.0),
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: Constants.mainTextSize,
                ),
              ),
            ),
            _buildArrow(),
          ],
        ),
      ),
    );
  }
}

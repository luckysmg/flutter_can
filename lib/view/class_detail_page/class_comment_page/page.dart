import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';

///
/// @created by 文景睿
/// description:课程详情->评论->加号（用户对课程进行评论的页面）
///
///
class ClassCommentPage extends StatefulWidget {
  final String oid;

  const ClassCommentPage({Key key, this.oid}) : super(key: key);

  @override
  _ClassCommentPageState createState() => _ClassCommentPageState();
}

class _ClassCommentPageState extends State<ClassCommentPage> {
  TextEditingController textEditingController;
  String oid;
  FocusNode focusNode;

  void requestAddComment() {
    focusNode.unfocus();
    if (textEditingController.text == null ||
        textEditingController.text.isEmpty) {
      return;
    }
    DioUtil.getInstance().doPost<SimpleEntity>(
        url: API.add_comment,
        context: context,
        param: {
          'bid': widget.oid,
          'type': 'CURRICULUM',
          'descript': textEditingController.text,
        },
        onSuccess: (data) async {
          Navigator.pop(context, true);
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    textEditingController = TextEditingController()..addListener(() {});
  }

  @override
  void dispose() async {
    focusNode.unfocus();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => focusNode.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        appBar: CustomNavigationBar(
          trailing: Material(
            child: GestureDetector(
              onTap: () => requestAddComment(),
              child: Text('发布',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: Constants.mainTextSize,
                      fontWeight: FontWeight.w500,
                      color: ColorUtil.mainTextColor)),
            ),
          ),
          title: '评价',
        ),
        body: Column(
          children: <Widget>[
            Gap.makeGap(height: 20),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(2),
              ),
              child: TextField(
                focusNode: focusNode,
                maxLength: 200,
                maxLines: 10,
                controller: textEditingController,
                decoration: InputDecoration(
                  counterStyle: TextStyle(
                      fontSize: ScreenUtil().setSp(25),
                      fontWeight: FontWeight.w500,
                      color: Colors.black26),
                  hintText: '写下你的评价吧',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

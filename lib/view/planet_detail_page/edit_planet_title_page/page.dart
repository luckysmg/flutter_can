import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/entity/simple_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/dialog_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';

///
/// @created by 文景睿
/// description:编辑星球介绍页面
///
class EditPlanetTitlePage extends StatefulWidget {
  ///把现在的介绍传入
  final String currentTitle;

  ///这个行星的oid
  final String oid;

  const EditPlanetTitlePage({Key key, this.currentTitle, this.oid})
      : super(key: key);

  @override
  _EditPlanetTitlePageState createState() => _EditPlanetTitlePageState();
}

class _EditPlanetTitlePageState extends State<EditPlanetTitlePage> {
  TextEditingController textEditingController;
  FocusNode focusNode;
  bool canClick;

  void requestChangeTitle() {
    if (textEditingController.text.isEmpty) {
      ToastUtil.show("请输入内容");
      return;
    }

    DialogUtil.showLoadingDialog(context: context);
    DioUtil.getInstance().doPost<SimpleEntity>(
        url: API.change_planet_title,
        context: context,
        param: {'title': textEditingController.text, 'oid': widget.oid},
        onSuccess: (data) {
          DialogUtil.closeLoadingDialog(context);
          Navigator.pop(context, true);
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }

  @override
  void initState() {
    super.initState();
    canClick = false;
    textEditingController = TextEditingController(text: widget.currentTitle);
    textEditingController.addListener(check);
    focusNode = FocusNode();
  }

  void check() {
    bool enabled = false;
    String title = textEditingController.text;
    if (title != widget.currentTitle && title.isNotEmpty && title.length >= 2) {
      enabled = true;
    }
    if (enabled != canClick) {
      canClick = enabled;
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var body = ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      children: <Widget>[
        buildInputBox(),
      ],
    );

    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        appBar: CustomNavigationBar(
          title: '编辑标题',
          trailing: buildConfirmButton(),
        ),
        body: body,
      ),
    );
  }

  Widget buildConfirmButton() {
    return CupertinoButton(
      borderRadius: BorderRadius.circular(2),
      color: ColorUtil.mainColor,
      disabledColor: ColorUtil.disabledButtonColor,
      minSize: 0,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Text('确认').withStyle(
          fontSize: Constants.mainTextSize, color: ColorUtil.darkBackTextColor),
      onPressed: canClick
          ? () {
              requestChangeTitle();
            }
          : null,
    );
  }

  Widget buildInputBox() {
    return Container(
      child: TextField(
        focusNode: focusNode,
        controller: textEditingController,
        style: TextStyle(fontSize: Constants.inputTextSize),
        inputFormatters: [
          BlacklistingTextInputFormatter(RegExp("[' ']")),
          WhitelistingTextInputFormatter(
              RegExp("[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]")),
          LengthLimitingTextInputFormatter(16),
        ],
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
      ).backgroundColor(ColorUtil.auxiliaryColor).cornerRadius(4),
    );
  }
}

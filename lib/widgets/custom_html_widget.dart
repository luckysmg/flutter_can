import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:neng/util/color_util.dart';
import 'package:html/dom.dart' as dom;
import 'package:neng/util/constants.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/util/toast_util.dart';

import 'load_asset_image.dart';

///
/// @created by 文景睿
/// description:统一的html解析控件
///
class CustomHtmlWidget extends StatelessWidget {
  ///数据
  final String data;

  const CustomHtmlWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      useRichText: true,
      /// ignore: missing_return
//      customRender: (node, children) {
//        if (node is dom.Element) {
//          switch (node.localName) {
//            case "img":
//              return CachedNetworkImage(
//                imageUrl: node.attributes["src"].toString(),
//                fit: BoxFit.fitWidth,
//                placeholder: (_, __) => LoadAssetImage(
//                  'default/pic_blank_banner',
//                  fit: BoxFit.fitWidth,
//                ),
//                errorWidget: (_, __, ___) => LoadAssetImage(
//                  'default/pic_blank_banner',
//                  fit: BoxFit.fitWidth,
//                ),
//              );
//            case "blockquote":
//              return Container(
//                color: ColorUtil.auxiliaryColor,
//                margin: EdgeInsets.only(top: 10),
//                padding: EdgeInsets.all(10),
//                child: Row(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    Container(
//                      margin: EdgeInsets.only(top: 10),
//                      child: LoadAssetImage(
//                        'ic_quotation',
//                        width: 16,
//                        fit: BoxFit.fitWidth,
//                      ),
//                    ),
//                    Gap.makeGap(width: 5),
//                    Expanded(
//                      child: Column(children: children),
//                    ),
//                  ],
//                ),
//              );
//          }
//        }
//      },
      data: data,
      defaultTextStyle: TextStyle(
          color: ColorUtil.mainTextColor,
          fontSize: Constants.secondTitleTextSize,
          height: 1.8),
      onImageTap: (url) {
        ToastUtil.show("查看图片");
      },
      customTextAlign: (dom.Node node) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "p":
              return TextAlign.justify;
          }
        }
        return TextAlign.justify;
      },
    );
  }
}

import 'package:neng/generated/json/base/json_convert_content.dart';

class PlanetDynamicListEntity with JsonConvert<PlanetDynamicListEntity> {
  int code;
  String message;
  int total;
  List<PlanetDynamicListRow> rows;
}

class PlanetDynamicListRow with JsonConvert<PlanetDynamicListRow> {
  String oid;
  String communityOid;
  String content;
  String userOid;
  String nickName;
  String headImageUrl;
  dynamic imgOne;
  dynamic imgTwo;
  dynamic imgThree;
  dynamic imgFour;
  dynamic imgFive;
  dynamic imgSix;
  dynamic imgSeven;
  dynamic imgEight;
  dynamic imgNine;
  String createTime;
  dynamic updateTime;
}

import 'package:neng/generated/json/base/json_convert_content.dart';

class PlanetDetailEntity with JsonConvert<PlanetDetailEntity> {
  int code;
  PlanetDetailData data;
  String message;
}

class PlanetDetailData with JsonConvert<PlanetDetailData> {
  String oid;
  String discoverCategoryOid;
  String title;
  String subtitle;
  String img;
  String notice;
  String userOid;
  dynamic createTime;
  int userNum;
  int essayNum;
  String joinStatus;
}

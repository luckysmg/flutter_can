import 'package:neng/generated/json/base/json_convert_content.dart';

class CheckPlanetInGalaxyEntity with JsonConvert<CheckPlanetInGalaxyEntity> {
  int code;
  String message;
  int total;
  List<CheckPlanetInGalaxyRow> rows;
}

class CheckPlanetInGalaxyRow with JsonConvert<CheckPlanetInGalaxyRow> {
  String oid;
  String discoverCategoryOid;
  String title;
  String subtitle;
  String img;
  String notice;
  String userOid;
  String nickName;
  String addTime;
  String createTime;
}

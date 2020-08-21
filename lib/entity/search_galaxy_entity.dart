import 'package:neng/generated/json/base/json_convert_content.dart';

class SearchGalaxyEntity with JsonConvert<SearchGalaxyEntity> {
  int code;
  String message;
  int total;
  List<SearchGalaxyRow> rows;
}

class SearchGalaxyRow with JsonConvert<SearchGalaxyRow> {
  String oid;
  String discoverCategoryOid;
  String title;
  dynamic subtitle;
  String img;
  dynamic notice;
  String userOid;
  String nickName;
  String createTime;
}

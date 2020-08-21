import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class SearchProfessionEntity with JsonConvert<SearchProfessionEntity> {
  int code;
  dynamic message;
  int total;
  List<SearchProfessionRow> rows;
}

class SearchProfessionRow with JsonConvert<SearchProfessionRow> {
  String oid;
  String name;
  int jobLevelNum;
  String jobThreshold;
  String roadmapOid;
  String roadmapName;
}

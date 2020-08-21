import 'package:neng/generated/json/base/json_convert_content.dart';

class KnowledgeListEntity with JsonConvert<KnowledgeListEntity> {
  int code;
  String message;
  int total;
  List<KnowledgeListRow> rows;
}

class KnowledgeListRow with JsonConvert<KnowledgeListRow> {
  String oid;
  String discoverCategoryOid;
  String title;
  String subtitle;
  String img;
  String notice;
  String userOid;
  String nickName;
  String createTime;
}

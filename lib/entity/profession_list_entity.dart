import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class ProfessionListEntity with JsonConvert<ProfessionListEntity> {
  int code;
  List<ProfessionListData> data;
  dynamic message;
}

class ProfessionListData with JsonConvert<ProfessionListData> {
  String oid;
  String name;
  List<ProfessionListDatachild> children;
}

class ProfessionListDatachild with JsonConvert<ProfessionListDatachild> {
  String oid;
  String name;
  double jobLevelNum;
  String jobThreshold;
  String roadmapOid;
  String roadmapName;
  bool isSelected;
}

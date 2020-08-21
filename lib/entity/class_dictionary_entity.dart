import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class ClassDictionaryEntity with JsonConvert<ClassDictionaryEntity> {
  int code;
  List<ClassDictionaryData> data;
  dynamic message;
}

class ClassDictionaryData with JsonConvert<ClassDictionaryData> {
  String oid;
  String title;
  String curriculumOid;
  dynamic videoUrl;
  String orderNum;
  String auditStatus;
  String blackStatus;
  String status;
  String freeStatus;
  String createTime;
}

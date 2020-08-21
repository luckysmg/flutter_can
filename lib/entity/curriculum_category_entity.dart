import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class CurriculumCategoryEntity with JsonConvert<CurriculumCategoryEntity> {
  int code;
  List<CurriculumCategoryData> data;
  dynamic message;
}

class CurriculumCategoryData with JsonConvert<CurriculumCategoryData> {
  String oid;
  String name;
  String level;
  List<CurriculumCategoryDatachild> children;
}

class CurriculumCategoryDatachild
    with JsonConvert<CurriculumCategoryDatachild> {
  String oid;
  String name;
  String level;
  List<CurriculumCategoryDatachildchild> children;
}

class CurriculumCategoryDatachildchild
    with JsonConvert<CurriculumCategoryDatachildchild> {
  String oid;
  String name;
  String level;
  dynamic children;
}

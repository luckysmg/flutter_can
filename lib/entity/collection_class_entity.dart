import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class CollectionClassEntity with JsonConvert<CollectionClassEntity> {
  int code;
  dynamic message;
  int total;
  List<CollectionClassRow> rows;
}

class CollectionClassRow with JsonConvert<CollectionClassRow> {
  String oid;
  String curriculumOid;
  String uid;
  String addingTime;
  String curriculumTitle;
  String curriculumPrice;
  String curriculumDiscountPrice;
  String beginEnlistTime;
  String endEnlistTime;
  String curriculumCommercialOid;
  String curriculumCommercialName;
  String curriculumAddress;
}

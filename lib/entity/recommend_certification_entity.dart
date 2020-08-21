import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class RecommendCertificationEntity
    with JsonConvert<RecommendCertificationEntity> {
  int code;
  dynamic message;
  int total;
  List<RecommandCertificationRows> rows;
}

class RecommandCertificationRows with JsonConvert<RecommandCertificationRows> {
  String oid;
  String name;
  String categoryOid;
  String unified;
}

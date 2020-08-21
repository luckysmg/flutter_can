import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class CertificationEntity with JsonConvert<CertificationEntity> {
  int code;
  List<CertificationData> data;
  dynamic message;
}

class CertificationData with JsonConvert<CertificationData> {
  String oid;
  String name;
  List<CertificationDatachild> children;
}

class CertificationDatachild with JsonConvert<CertificationDatachild> {
  String oid;
  String name;
  String categoryOid;
  String unified;
  String recommend;
  String hot;
}

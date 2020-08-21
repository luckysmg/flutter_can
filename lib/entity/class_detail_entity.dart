import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class ClassDetailEntity with JsonConvert<ClassDetailEntity> {
  int code;
  ClassDetailData data;
  dynamic message;
}

class ClassDetailData with JsonConvert<ClassDetailData> {
  String level;
  String oid;
  String title;
  String imageUrl;
  String price;
  String discountPrice;
  String commercialOid;
  String commercialName;
  String provinceOid;
  String provinceName;
  String cityOid;
  String cityName;
  String districtOid;
  String districtName;
  String online;
  String offline;
  String auditStatus;
  String shelfStatus;
  String context;
  String collectionStatus;
  int collectionNumber;
  int periods;
}

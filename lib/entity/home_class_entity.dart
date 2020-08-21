import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class HomeClassEntity with JsonConvert<HomeClassEntity> {
  int code;
  dynamic message;
  int total;
  List<HomeClassRow> rows;
}

class HomeClassRow with JsonConvert<HomeClassRow> {
  String oid;
  String title;
  String categoryOid;
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
  String blackStatus;
  String status;
  String recommendStatus;
  String freeStatus;
  String level;
  int periods;
}

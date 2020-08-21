import 'package:neng/generated/json/base/json_convert_content.dart';

class ExactLevelClassEntity with JsonConvert<ExactLevelClassEntity> {
  int code;
  String message;
  int total;
  List<ExactLevelClassRow> rows;
}

class ExactLevelClassRow with JsonConvert<ExactLevelClassRow> {
  String oid;
  String title;
  String categoryOid;
  String imageUrl;
  String price;
  String discountPrice;
  String commercialOid;
  String commercialName;
  String periods;
  String provinceOid;
  String provinceName;
  String cityOid;
  String cityName;
  String districtOid;
  String districtName;
  String auditStatus;
  String shelfStatus;
  String blackStatus;
  String level;
  String status;
  String createTime;
  String recommendStatus;
  String freeStatus;
}

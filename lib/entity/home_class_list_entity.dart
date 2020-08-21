import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class HomeClassListEntity with JsonConvert<HomeClassListEntity> {
  int code;
  List<HomeClassListData> data;
  String message;
}

class HomeClassListData with JsonConvert<HomeClassListData> {
  String level;
  List<HomeClassListDataData> data;
}

class HomeClassListDataData with JsonConvert<HomeClassListDataData> {
  String oid;
  String title;
  String categoryOid;
  String imageUrl;
  String price;
  String discountPrice;
  String commercialOid;
  String commercialName;
  int periods;
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

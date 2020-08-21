import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class UserProfileEntity with JsonConvert<UserProfileEntity> {
  String oid;
  String nickName;
  String headImageUrl;
  String gender;
  String provinceCode;
  String provinceName;
  String cityCode;
  String cityName;
  String districtCode;
  String districtName;
  String addrDetail;
  String postalCode;
  double longitude;
  double latitude;
  int code;
  String message;
  String professionName;
  String professionCode;
  String passInited;
  String galaxyCode;
  String galaxyName;
}

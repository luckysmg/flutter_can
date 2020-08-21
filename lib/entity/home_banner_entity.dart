import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class HomeBannerEntity with JsonConvert<HomeBannerEntity> {
  int code;
  List<HomeBannerData> data;
  dynamic message;
}

class HomeBannerData with JsonConvert<HomeBannerData> {
  String oid;
  String title;
  String imageUrl;
  dynamic url;
  int orderNum;
  dynamic createTime;
  String status;
}

import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class DiscoverItemDetailEntity with JsonConvert<DiscoverItemDetailEntity> {
  int code;
  DiscoverItemDetailData data;
  dynamic message;
}

class DiscoverItemDetailData with JsonConvert<DiscoverItemDetailData> {
  String oid;
  String title;
  String imageUrl;
  dynamic createCommercialOid;
  String createCommercialName;
  dynamic createUserOid;
  String createUserName;
  String createTime;
  dynamic updateCommercialOid;
  String updateCommercialName;
  dynamic updateUserOid;
  String updateUserName;
  String updateTime;
  String context;
  String collectionStatus;
  int collectionNumber;
  String likeStatus;
  int likeNumber;
}

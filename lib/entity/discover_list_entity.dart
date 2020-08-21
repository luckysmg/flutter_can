import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class DiscoverListEntity with JsonConvert<DiscoverListEntity> {
  int total;
  dynamic message;
  int code;
  List<DiscoverListRow> rows;
}

class DiscoverListRow with JsonConvert<DiscoverListRow> {
  String oid;
  String title;
  String imageUrl;
  String createCommercialOid;
  String createCommercialName;
  String createUserOid;
  String createUserName;
  String createTime;
  String updateCommercialOid;
  String updateCommercialName;
  String updateUserOid;
  String updateUserName;
  String updateTime;
  String auditStatus;
  String blackStatus;
  String status;
}

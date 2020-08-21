import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class CommentListEntity with JsonConvert<CommentListEntity> {
  int code;
  dynamic message;
  int total;
  List<CommantListRows> rows;
}

class CommantListRows with JsonConvert<CommantListRows> {
  String oid;
  String bid;
  String type;
  String uid;
  String nickName;
  String descript;
  String createTime;
  String headImageUrl;
}

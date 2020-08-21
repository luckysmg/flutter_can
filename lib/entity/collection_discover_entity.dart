import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class CollectionDiscoverEntity with JsonConvert<CollectionDiscoverEntity> {
  int code;
  dynamic message;
  int total;
  List<CollectionDiscoverRow> rows;
}

class CollectionDiscoverRow with JsonConvert<CollectionDiscoverRow> {
  String oid;
  String discoverOid;
  String uid;
  String addingTime;
  String discoverTitle;
  String commercialOid;
  String commercialName;
}

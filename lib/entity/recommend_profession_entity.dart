import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class RecommendProfessionEntity with JsonConvert<RecommendProfessionEntity> {
  int code;
  List<RecommendProfessionData> data;
  String message;
}

class RecommendProfessionData with JsonConvert<RecommendProfessionData> {
  String oid;
  String name;
  String jobThreshold;
  String roadmapOid;
  String roadmapName;
}

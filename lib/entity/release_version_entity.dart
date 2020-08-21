import 'package:neng/generated/json/base/json_convert_content.dart';

class ReleaseVersionEntity with JsonConvert<ReleaseVersionEntity> {
  int code;
  String message;
  String types;
  String application;
  String versions;
  String downloadLink;
  String strategy;
  String platform;
  String md5;
}

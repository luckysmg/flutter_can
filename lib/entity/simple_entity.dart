import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class SimpleEntity with JsonConvert<SimpleEntity> {
  int code;
  String message;
}

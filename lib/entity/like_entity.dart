import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class LikeEntity with JsonConvert<LikeEntity> {
  int code;
  dynamic message;
  int likeNumber;
}

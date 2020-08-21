import 'package:neng/generated/json/base/json_convert_content.dart';

class LoginEntity with JsonConvert<LoginEntity> {
  int code;
  String message;
  String accessToken;
  String refreshToken;
  int refreshTime;
}

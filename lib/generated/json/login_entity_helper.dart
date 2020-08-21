import 'package:neng/entity/login_entity.dart';

loginEntityFromJson(LoginEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['message'] != null) {
    data.message = json['message']?.toString();
  }
  if (json['accessToken'] != null) {
    data.accessToken = json['accessToken']?.toString();
  }
  if (json['refreshToken'] != null) {
    data.refreshToken = json['refreshToken']?.toString();
  }
  if (json['refreshTime'] != null) {
    data.refreshTime = json['refreshTime']?.toInt();
  }
  return data;
}

Map<String, dynamic> loginEntityToJson(LoginEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['accessToken'] = entity.accessToken;
  data['refreshToken'] = entity.refreshToken;
  data['refreshTime'] = entity.refreshTime;
  return data;
}

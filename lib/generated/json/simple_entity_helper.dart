import 'package:neng/entity/simple_entity.dart';

simpleEntityFromJson(SimpleEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['message'] != null) {
    data.message = json['message']?.toString();
  }
  return data;
}

Map<String, dynamic> simpleEntityToJson(SimpleEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['message'] = entity.message;
  return data;
}

import 'package:neng/entity/like_entity.dart';

likeEntityFromJson(LikeEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['message'] != null) {
    data.message = json['message'];
  }
  if (json['likeNumber'] != null) {
    data.likeNumber = json['likeNumber']?.toInt();
  }
  return data;
}

Map<String, dynamic> likeEntityToJson(LikeEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['likeNumber'] = entity.likeNumber;
  return data;
}

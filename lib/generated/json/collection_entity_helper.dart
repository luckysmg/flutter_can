import 'package:neng/entity/collection_entity.dart';

collectionEntityFromJson(CollectionEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['message'] != null) {
    data.message = json['message'];
  }
  if (json['collectionNumber'] != null) {
    data.collectionNumber = json['collectionNumber'];
  }
  return data;
}

Map<String, dynamic> collectionEntityToJson(CollectionEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['collectionNumber'] = entity.collectionNumber;
  return data;
}

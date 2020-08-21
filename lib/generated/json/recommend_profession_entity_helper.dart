import 'package:neng/entity/recommend_profession_entity.dart';

recommendProfessionEntityFromJson(
    RecommendProfessionEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new List<RecommendProfessionData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new RecommendProfessionData().fromJson(v));
    });
  }
  if (json['message'] != null) {
    data.message = json['message']?.toString();
  }
  return data;
}

Map<String, dynamic> recommendProfessionEntityToJson(
    RecommendProfessionEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  data['message'] = entity.message;
  return data;
}

recommendProfessionDataFromJson(
    RecommendProfessionData data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['jobThreshold'] != null) {
    data.jobThreshold = json['jobThreshold']?.toString();
  }
  if (json['roadmapOid'] != null) {
    data.roadmapOid = json['roadmapOid']?.toString();
  }
  if (json['roadmapName'] != null) {
    data.roadmapName = json['roadmapName']?.toString();
  }
  return data;
}

Map<String, dynamic> recommendProfessionDataToJson(
    RecommendProfessionData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['name'] = entity.name;
  data['jobThreshold'] = entity.jobThreshold;
  data['roadmapOid'] = entity.roadmapOid;
  data['roadmapName'] = entity.roadmapName;
  return data;
}

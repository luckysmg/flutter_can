import 'package:neng/entity/search_profession_entity.dart';

searchProfessionEntityFromJson(
    SearchProfessionEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['message'] != null) {
    data.message = json['message'];
  }
  if (json['total'] != null) {
    data.total = json['total']?.toInt();
  }
  if (json['rows'] != null) {
    data.rows = new List<SearchProfessionRow>();
    (json['rows'] as List).forEach((v) {
      data.rows.add(new SearchProfessionRow().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> searchProfessionEntityToJson(
    SearchProfessionEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['total'] = entity.total;
  if (entity.rows != null) {
    data['rows'] = entity.rows.map((v) => v.toJson()).toList();
  }
  return data;
}

searchProfessionRowFromJson(
    SearchProfessionRow data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['jobLevelNum'] != null) {
    data.jobLevelNum = json['jobLevelNum']?.toInt();
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

Map<String, dynamic> searchProfessionRowToJson(SearchProfessionRow entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['name'] = entity.name;
  data['jobLevelNum'] = entity.jobLevelNum;
  data['jobThreshold'] = entity.jobThreshold;
  data['roadmapOid'] = entity.roadmapOid;
  data['roadmapName'] = entity.roadmapName;
  return data;
}

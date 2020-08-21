import 'package:neng/entity/recommend_certification_entity.dart';

recommendCertificationEntityFromJson(
    RecommendCertificationEntity data, Map<String, dynamic> json) {
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
    data.rows = new List<RecommandCertificationRows>();
    (json['rows'] as List).forEach((v) {
      data.rows.add(new RecommandCertificationRows().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> recommendCertificationEntityToJson(
    RecommendCertificationEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['total'] = entity.total;
  if (entity.rows != null) {
    data['rows'] = entity.rows.map((v) => v.toJson()).toList();
  }
  return data;
}

recommandCertificationRowsFromJson(
    RecommandCertificationRows data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['categoryOid'] != null) {
    data.categoryOid = json['categoryOid']?.toString();
  }
  if (json['unified'] != null) {
    data.unified = json['unified']?.toString();
  }
  return data;
}

Map<String, dynamic> recommandCertificationRowsToJson(
    RecommandCertificationRows entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['name'] = entity.name;
  data['categoryOid'] = entity.categoryOid;
  data['unified'] = entity.unified;
  return data;
}

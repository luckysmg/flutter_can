import 'package:neng/entity/certification_entity.dart';

certificationEntityFromJson(
    CertificationEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new List<CertificationData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new CertificationData().fromJson(v));
    });
  }
  if (json['message'] != null) {
    data.message = json['message'];
  }
  return data;
}

Map<String, dynamic> certificationEntityToJson(CertificationEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  data['message'] = entity.message;
  return data;
}

certificationDataFromJson(CertificationData data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['children'] != null) {
    data.children = new List<CertificationDatachild>();
    (json['children'] as List).forEach((v) {
      data.children.add(new CertificationDatachild().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> certificationDataToJson(CertificationData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['name'] = entity.name;
  if (entity.children != null) {
    data['children'] = entity.children.map((v) => v.toJson()).toList();
  }
  return data;
}

certificationDatachildFromJson(
    CertificationDatachild data, Map<String, dynamic> json) {
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
  if (json['recommend'] != null) {
    data.recommend = json['recommend']?.toString();
  }
  if (json['hot'] != null) {
    data.hot = json['hot']?.toString();
  }
  return data;
}

Map<String, dynamic> certificationDatachildToJson(
    CertificationDatachild entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['name'] = entity.name;
  data['categoryOid'] = entity.categoryOid;
  data['unified'] = entity.unified;
  data['recommend'] = entity.recommend;
  data['hot'] = entity.hot;
  return data;
}

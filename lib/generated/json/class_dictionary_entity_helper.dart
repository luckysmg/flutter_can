import 'package:neng/entity/class_dictionary_entity.dart';

classDictionaryEntityFromJson(
    ClassDictionaryEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new List<ClassDictionaryData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new ClassDictionaryData().fromJson(v));
    });
  }
  if (json['message'] != null) {
    data.message = json['message'];
  }
  return data;
}

Map<String, dynamic> classDictionaryEntityToJson(ClassDictionaryEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  data['message'] = entity.message;
  return data;
}

classDictionaryDataFromJson(
    ClassDictionaryData data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['title'] != null) {
    data.title = json['title']?.toString();
  }
  if (json['curriculumOid'] != null) {
    data.curriculumOid = json['curriculumOid']?.toString();
  }
  if (json['videoUrl'] != null) {
    data.videoUrl = json['videoUrl'];
  }
  if (json['orderNum'] != null) {
    data.orderNum = json['orderNum']?.toString();
  }
  if (json['auditStatus'] != null) {
    data.auditStatus = json['auditStatus']?.toString();
  }
  if (json['blackStatus'] != null) {
    data.blackStatus = json['blackStatus']?.toString();
  }
  if (json['status'] != null) {
    data.status = json['status']?.toString();
  }
  if (json['freeStatus'] != null) {
    data.freeStatus = json['freeStatus']?.toString();
  }
  if (json['createTime'] != null) {
    data.createTime = json['createTime']?.toString();
  }
  return data;
}

Map<String, dynamic> classDictionaryDataToJson(ClassDictionaryData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['title'] = entity.title;
  data['curriculumOid'] = entity.curriculumOid;
  data['videoUrl'] = entity.videoUrl;
  data['orderNum'] = entity.orderNum;
  data['auditStatus'] = entity.auditStatus;
  data['blackStatus'] = entity.blackStatus;
  data['status'] = entity.status;
  data['freeStatus'] = entity.freeStatus;
  data['createTime'] = entity.createTime;
  return data;
}

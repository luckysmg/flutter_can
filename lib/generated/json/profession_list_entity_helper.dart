import 'package:neng/entity/profession_list_entity.dart';

professionListEntityFromJson(
    ProfessionListEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new List<ProfessionListData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new ProfessionListData().fromJson(v));
    });
  }
  if (json['message'] != null) {
    data.message = json['message'];
  }
  return data;
}

Map<String, dynamic> professionListEntityToJson(ProfessionListEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  data['message'] = entity.message;
  return data;
}

professionListDataFromJson(ProfessionListData data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['children'] != null) {
    data.children = new List<ProfessionListDatachild>();
    (json['children'] as List).forEach((v) {
      data.children.add(new ProfessionListDatachild().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> professionListDataToJson(ProfessionListData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['name'] = entity.name;
  if (entity.children != null) {
    data['children'] = entity.children.map((v) => v.toJson()).toList();
  }
  return data;
}

professionListDatachildFromJson(
    ProfessionListDatachild data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['jobLevelNum'] != null) {
    data.jobLevelNum = json['jobLevelNum']?.toDouble();
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
  if (json['isSelected'] != null) {
    data.isSelected = json['isSelected'];
  }
  return data;
}

Map<String, dynamic> professionListDatachildToJson(
    ProfessionListDatachild entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['name'] = entity.name;
  data['jobLevelNum'] = entity.jobLevelNum;
  data['jobThreshold'] = entity.jobThreshold;
  data['roadmapOid'] = entity.roadmapOid;
  data['roadmapName'] = entity.roadmapName;
  data['isSelected'] = entity.isSelected;
  return data;
}

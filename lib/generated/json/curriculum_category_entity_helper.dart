import 'package:neng/entity/curriculum_category_entity.dart';

curriculumCategoryEntityFromJson(
    CurriculumCategoryEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new List<CurriculumCategoryData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new CurriculumCategoryData().fromJson(v));
    });
  }
  if (json['message'] != null) {
    data.message = json['message'];
  }
  return data;
}

Map<String, dynamic> curriculumCategoryEntityToJson(
    CurriculumCategoryEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  data['message'] = entity.message;
  return data;
}

curriculumCategoryDataFromJson(
    CurriculumCategoryData data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['level'] != null) {
    data.level = json['level']?.toString();
  }
  if (json['children'] != null) {
    data.children = new List<CurriculumCategoryDatachild>();
    (json['children'] as List).forEach((v) {
      data.children.add(new CurriculumCategoryDatachild().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> curriculumCategoryDataToJson(
    CurriculumCategoryData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['name'] = entity.name;
  data['level'] = entity.level;
  if (entity.children != null) {
    data['children'] = entity.children.map((v) => v.toJson()).toList();
  }
  return data;
}

curriculumCategoryDatachildFromJson(
    CurriculumCategoryDatachild data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['level'] != null) {
    data.level = json['level']?.toString();
  }
  if (json['children'] != null) {
    data.children = new List<CurriculumCategoryDatachildchild>();
    (json['children'] as List).forEach((v) {
      data.children.add(new CurriculumCategoryDatachildchild().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> curriculumCategoryDatachildToJson(
    CurriculumCategoryDatachild entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['name'] = entity.name;
  data['level'] = entity.level;
  if (entity.children != null) {
    data['children'] = entity.children.map((v) => v.toJson()).toList();
  }
  return data;
}

curriculumCategoryDatachildchildFromJson(
    CurriculumCategoryDatachildchild data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['level'] != null) {
    data.level = json['level']?.toString();
  }
  if (json['children'] != null) {
    data.children = json['children'];
  }
  return data;
}

Map<String, dynamic> curriculumCategoryDatachildchildToJson(
    CurriculumCategoryDatachildchild entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['name'] = entity.name;
  data['level'] = entity.level;
  data['children'] = entity.children;
  return data;
}

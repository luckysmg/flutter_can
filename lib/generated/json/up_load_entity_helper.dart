import 'package:neng/entity/up_load_entity.dart';

upLoadEntityFromJson(UpLoadEntity data, Map<String, dynamic> json) {
  if (json['files'] != null) {
    data.files = new List<UpLoadFile>();
    (json['files'] as List).forEach((v) {
      data.files.add(new UpLoadFile().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> upLoadEntityToJson(UpLoadEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.files != null) {
    data['files'] = entity.files.map((v) => v.toJson()).toList();
  }
  return data;
}

upLoadFileFromJson(UpLoadFile data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['field'] != null) {
    data.field = json['field']?.toString();
  }
  if (json['md5'] != null) {
    data.md5 = json['md5']?.toString();
  }
  if (json['filename'] != null) {
    data.filename = json['filename']?.toString();
  }
  if (json['suffix'] != null) {
    data.suffix = json['suffix']?.toString();
  }
  if (json['storage'] != null) {
    data.storage = json['storage']?.toString();
  }
  if (json['displaySize'] != null) {
    data.displaySize = json['displaySize']?.toString();
  }
  if (json['size'] != null) {
    data.size = json['size']?.toInt();
  }
  if (json['url'] != null) {
    data.url = json['url']?.toString();
  }
  if (json['uploadTime'] != null) {
    data.uploadTime = json['uploadTime']?.toString();
  }
  if (json['groups'] != null) {
    data.groups = json['groups']?.toString();
  }
  if (json['type'] != null) {
    data.type = json['type']?.toString();
  }
  return data;
}

Map<String, dynamic> upLoadFileToJson(UpLoadFile entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['field'] = entity.field;
  data['md5'] = entity.md5;
  data['filename'] = entity.filename;
  data['suffix'] = entity.suffix;
  data['storage'] = entity.storage;
  data['displaySize'] = entity.displaySize;
  data['size'] = entity.size;
  data['url'] = entity.url;
  data['uploadTime'] = entity.uploadTime;
  data['groups'] = entity.groups;
  data['type'] = entity.type;
  return data;
}

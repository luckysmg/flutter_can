import 'package:neng/entity/release_version_entity.dart';

releaseVersionEntityFromJson(ReleaseVersionEntity data, Map<String, dynamic> json) {
  if (json['types'] != null) {
    data.types = json['types']?.toString();
  }
  if (json['application'] != null) {
    data.application = json['application']?.toString();
  }
  if (json['versions'] != null) {
    data.versions = json['versions']?.toString();
  }
  if (json['downloadLink'] != null) {
    data.downloadLink = json['downloadLink']?.toString();
  }
  if (json['strategy'] != null) {
    data.strategy = json['strategy']?.toString();
  }
  if (json['platform'] != null) {
    data.platform = json['platform']?.toString();
  }
  if (json['md5'] != null) {
    data.md5 = json['md5']?.toString();
  }
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['message'] != null) {
    data.message = json['message']?.toString();
  }
  return data;
}

Map<String, dynamic> releaseVersionEntityToJson(ReleaseVersionEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['types'] = entity.types;
  data['application'] = entity.application;
  data['versions'] = entity.versions;
  data['downloadLink'] = entity.downloadLink;
  data['strategy'] = entity.strategy;
  data['platform'] = entity.platform;
  data['md5'] = entity.md5;
  data['code'] = entity.code;
  data['message'] = entity.message;
  return data;
}

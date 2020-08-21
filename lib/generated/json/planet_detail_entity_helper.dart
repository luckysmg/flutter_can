import 'package:neng/entity/planet_detail_entity.dart';

planetDetailEntityFromJson(PlanetDetailEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new PlanetDetailData().fromJson(json['data']);
  }
  if (json['message'] != null) {
    data.message = json['message']?.toString();
  }
  return data;
}

Map<String, dynamic> planetDetailEntityToJson(PlanetDetailEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  data['message'] = entity.message;
  return data;
}

planetDetailDataFromJson(PlanetDetailData data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['discoverCategoryOid'] != null) {
    data.discoverCategoryOid = json['discoverCategoryOid']?.toString();
  }
  if (json['title'] != null) {
    data.title = json['title']?.toString();
  }
  if (json['subtitle'] != null) {
    data.subtitle = json['subtitle']?.toString();
  }
  if (json['img'] != null) {
    data.img = json['img']?.toString();
  }
  if (json['notice'] != null) {
    data.notice = json['notice']?.toString();
  }
  if (json['userOid'] != null) {
    data.userOid = json['userOid']?.toString();
  }
  if (json['createTime'] != null) {
    data.createTime = json['createTime'];
  }
  if (json['userNum'] != null) {
    data.userNum = json['userNum']?.toInt();
  }
  if (json['essayNum'] != null) {
    data.essayNum = json['essayNum']?.toInt();
  }
  if (json['joinStatus'] != null) {
    data.joinStatus = json['joinStatus']?.toString();
  }
  return data;
}

Map<String, dynamic> planetDetailDataToJson(PlanetDetailData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['discoverCategoryOid'] = entity.discoverCategoryOid;
  data['title'] = entity.title;
  data['subtitle'] = entity.subtitle;
  data['img'] = entity.img;
  data['notice'] = entity.notice;
  data['userOid'] = entity.userOid;
  data['createTime'] = entity.createTime;
  data['userNum'] = entity.userNum;
  data['essayNum'] = entity.essayNum;
  data['joinStatus'] = entity.joinStatus;
  return data;
}

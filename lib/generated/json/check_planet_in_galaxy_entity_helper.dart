import 'package:neng/entity/check_planet_in_galaxy_entity.dart';

checkPlanetInGalaxyEntityFromJson(
    CheckPlanetInGalaxyEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['message'] != null) {
    data.message = json['message']?.toString();
  }
  if (json['total'] != null) {
    data.total = json['total']?.toInt();
  }
  if (json['rows'] != null) {
    data.rows = new List<CheckPlanetInGalaxyRow>();
    (json['rows'] as List).forEach((v) {
      data.rows.add(new CheckPlanetInGalaxyRow().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> checkPlanetInGalaxyEntityToJson(
    CheckPlanetInGalaxyEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['total'] = entity.total;
  if (entity.rows != null) {
    data['rows'] = entity.rows.map((v) => v.toJson()).toList();
  }
  return data;
}

checkPlanetInGalaxyRowFromJson(
    CheckPlanetInGalaxyRow data, Map<String, dynamic> json) {
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
  if (json['nickName'] != null) {
    data.nickName = json['nickName']?.toString();
  }
  if (json['addTime'] != null) {
    data.addTime = json['addTime']?.toString();
  }
  if (json['createTime'] != null) {
    data.createTime = json['createTime']?.toString();
  }
  return data;
}

Map<String, dynamic> checkPlanetInGalaxyRowToJson(
    CheckPlanetInGalaxyRow entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['discoverCategoryOid'] = entity.discoverCategoryOid;
  data['title'] = entity.title;
  data['subtitle'] = entity.subtitle;
  data['img'] = entity.img;
  data['notice'] = entity.notice;
  data['userOid'] = entity.userOid;
  data['nickName'] = entity.nickName;
  data['addTime'] = entity.addTime;
  data['createTime'] = entity.createTime;
  return data;
}

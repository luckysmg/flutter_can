import 'package:neng/entity/galaxy_class_entity.dart';

galaxyClassEntityFromJson(GalaxyClassEntity data, Map<String, dynamic> json) {
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
    data.rows = new List<GalaxyClassRow>();
    (json['rows'] as List).forEach((v) {
      data.rows.add(new GalaxyClassRow().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> galaxyClassEntityToJson(GalaxyClassEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['total'] = entity.total;
  if (entity.rows != null) {
    data['rows'] = entity.rows.map((v) => v.toJson()).toList();
  }
  return data;
}

galaxyClassRowFromJson(GalaxyClassRow data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['img'] != null) {
    data.img = json['img']?.toString();
  }
  return data;
}

Map<String, dynamic> galaxyClassRowToJson(GalaxyClassRow entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['name'] = entity.name;
  data['img'] = entity.img;
  return data;
}

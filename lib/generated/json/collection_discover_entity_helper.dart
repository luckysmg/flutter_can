import 'package:neng/entity/collection_discover_entity.dart';

collectionDiscoverEntityFromJson(
    CollectionDiscoverEntity data, Map<String, dynamic> json) {
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
    data.rows = new List<CollectionDiscoverRow>();
    (json['rows'] as List).forEach((v) {
      data.rows.add(new CollectionDiscoverRow().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> collectionDiscoverEntityToJson(
    CollectionDiscoverEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['total'] = entity.total;
  if (entity.rows != null) {
    data['rows'] = entity.rows.map((v) => v.toJson()).toList();
  }
  return data;
}

collectionDiscoverRowFromJson(
    CollectionDiscoverRow data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['discoverOid'] != null) {
    data.discoverOid = json['discoverOid']?.toString();
  }
  if (json['uid'] != null) {
    data.uid = json['uid']?.toString();
  }
  if (json['addingTime'] != null) {
    data.addingTime = json['addingTime']?.toString();
  }
  if (json['discoverTitle'] != null) {
    data.discoverTitle = json['discoverTitle']?.toString();
  }
  if (json['commercialOid'] != null) {
    data.commercialOid = json['commercialOid']?.toString();
  }
  if (json['commercialName'] != null) {
    data.commercialName = json['commercialName']?.toString();
  }
  return data;
}

Map<String, dynamic> collectionDiscoverRowToJson(CollectionDiscoverRow entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['discoverOid'] = entity.discoverOid;
  data['uid'] = entity.uid;
  data['addingTime'] = entity.addingTime;
  data['discoverTitle'] = entity.discoverTitle;
  data['commercialOid'] = entity.commercialOid;
  data['commercialName'] = entity.commercialName;
  return data;
}

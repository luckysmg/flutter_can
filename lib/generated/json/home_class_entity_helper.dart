import 'package:neng/entity/home_class_entity.dart';

homeClassEntityFromJson(HomeClassEntity data, Map<String, dynamic> json) {
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
    data.rows = new List<HomeClassRow>();
    (json['rows'] as List).forEach((v) {
      data.rows.add(new HomeClassRow().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> homeClassEntityToJson(HomeClassEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['total'] = entity.total;
  if (entity.rows != null) {
    data['rows'] = entity.rows.map((v) => v.toJson()).toList();
  }
  return data;
}

homeClassRowFromJson(HomeClassRow data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['title'] != null) {
    data.title = json['title']?.toString();
  }
  if (json['categoryOid'] != null) {
    data.categoryOid = json['categoryOid']?.toString();
  }
  if (json['imageUrl'] != null) {
    data.imageUrl = json['imageUrl']?.toString();
  }
  if (json['price'] != null) {
    data.price = json['price']?.toString();
  }
  if (json['discountPrice'] != null) {
    data.discountPrice = json['discountPrice']?.toString();
  }
  if (json['commercialOid'] != null) {
    data.commercialOid = json['commercialOid']?.toString();
  }
  if (json['commercialName'] != null) {
    data.commercialName = json['commercialName']?.toString();
  }
  if (json['provinceOid'] != null) {
    data.provinceOid = json['provinceOid']?.toString();
  }
  if (json['provinceName'] != null) {
    data.provinceName = json['provinceName']?.toString();
  }
  if (json['cityOid'] != null) {
    data.cityOid = json['cityOid']?.toString();
  }
  if (json['cityName'] != null) {
    data.cityName = json['cityName']?.toString();
  }
  if (json['districtOid'] != null) {
    data.districtOid = json['districtOid']?.toString();
  }
  if (json['districtName'] != null) {
    data.districtName = json['districtName']?.toString();
  }
  if (json['online'] != null) {
    data.online = json['online']?.toString();
  }
  if (json['offline'] != null) {
    data.offline = json['offline']?.toString();
  }
  if (json['auditStatus'] != null) {
    data.auditStatus = json['auditStatus']?.toString();
  }
  if (json['shelfStatus'] != null) {
    data.shelfStatus = json['shelfStatus']?.toString();
  }
  if (json['blackStatus'] != null) {
    data.blackStatus = json['blackStatus']?.toString();
  }
  if (json['status'] != null) {
    data.status = json['status']?.toString();
  }
  if (json['recommendStatus'] != null) {
    data.recommendStatus = json['recommendStatus']?.toString();
  }
  if (json['freeStatus'] != null) {
    data.freeStatus = json['freeStatus']?.toString();
  }
  if (json['level'] != null) {
    data.level = json['level']?.toString();
  }
  if (json['periods'] != null) {
    data.periods = json['periods']?.toInt();
  }
  return data;
}

Map<String, dynamic> homeClassRowToJson(HomeClassRow entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['title'] = entity.title;
  data['categoryOid'] = entity.categoryOid;
  data['imageUrl'] = entity.imageUrl;
  data['price'] = entity.price;
  data['discountPrice'] = entity.discountPrice;
  data['commercialOid'] = entity.commercialOid;
  data['commercialName'] = entity.commercialName;
  data['provinceOid'] = entity.provinceOid;
  data['provinceName'] = entity.provinceName;
  data['cityOid'] = entity.cityOid;
  data['cityName'] = entity.cityName;
  data['districtOid'] = entity.districtOid;
  data['districtName'] = entity.districtName;
  data['online'] = entity.online;
  data['offline'] = entity.offline;
  data['auditStatus'] = entity.auditStatus;
  data['shelfStatus'] = entity.shelfStatus;
  data['blackStatus'] = entity.blackStatus;
  data['status'] = entity.status;
  data['recommendStatus'] = entity.recommendStatus;
  data['freeStatus'] = entity.freeStatus;
  data['level'] = entity.level;
  data['periods'] = entity.periods;
  return data;
}

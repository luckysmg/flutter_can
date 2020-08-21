import 'package:neng/entity/class_detail_entity.dart';

classDetailEntityFromJson(ClassDetailEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new ClassDetailData().fromJson(json['data']);
  }
  if (json['message'] != null) {
    data.message = json['message'];
  }
  return data;
}

Map<String, dynamic> classDetailEntityToJson(ClassDetailEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  data['message'] = entity.message;
  return data;
}

classDetailDataFromJson(ClassDetailData data, Map<String, dynamic> json) {
  if (json['level'] != null) {
    data.level = json['level']?.toString();
  }
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['title'] != null) {
    data.title = json['title']?.toString();
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
  if (json['context'] != null) {
    data.context = json['context']?.toString();
  }
  if (json['collectionStatus'] != null) {
    data.collectionStatus = json['collectionStatus']?.toString();
  }
  if (json['collectionNumber'] != null) {
    data.collectionNumber = json['collectionNumber']?.toInt();
  }
  if (json['periods'] != null) {
    data.periods = json['periods']?.toInt();
  }
  return data;
}

Map<String, dynamic> classDetailDataToJson(ClassDetailData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['level'] = entity.level;
  data['oid'] = entity.oid;
  data['title'] = entity.title;
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
  data['context'] = entity.context;
  data['collectionStatus'] = entity.collectionStatus;
  data['collectionNumber'] = entity.collectionNumber;
  data['periods'] = entity.periods;
  return data;
}

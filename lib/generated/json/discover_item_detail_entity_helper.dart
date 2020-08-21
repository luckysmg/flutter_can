import 'package:neng/entity/discover_item_detail_entity.dart';

discoverItemDetailEntityFromJson(
    DiscoverItemDetailEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new DiscoverItemDetailData().fromJson(json['data']);
  }
  if (json['message'] != null) {
    data.message = json['message'];
  }
  return data;
}

Map<String, dynamic> discoverItemDetailEntityToJson(
    DiscoverItemDetailEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  data['message'] = entity.message;
  return data;
}

discoverItemDetailDataFromJson(
    DiscoverItemDetailData data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['title'] != null) {
    data.title = json['title']?.toString();
  }
  if (json['imageUrl'] != null) {
    data.imageUrl = json['imageUrl']?.toString();
  }
  if (json['createCommercialOid'] != null) {
    data.createCommercialOid = json['createCommercialOid'];
  }
  if (json['createCommercialName'] != null) {
    data.createCommercialName = json['createCommercialName']?.toString();
  }
  if (json['createUserOid'] != null) {
    data.createUserOid = json['createUserOid'];
  }
  if (json['createUserName'] != null) {
    data.createUserName = json['createUserName']?.toString();
  }
  if (json['createTime'] != null) {
    data.createTime = json['createTime']?.toString();
  }
  if (json['updateCommercialOid'] != null) {
    data.updateCommercialOid = json['updateCommercialOid'];
  }
  if (json['updateCommercialName'] != null) {
    data.updateCommercialName = json['updateCommercialName']?.toString();
  }
  if (json['updateUserOid'] != null) {
    data.updateUserOid = json['updateUserOid'];
  }
  if (json['updateUserName'] != null) {
    data.updateUserName = json['updateUserName']?.toString();
  }
  if (json['updateTime'] != null) {
    data.updateTime = json['updateTime']?.toString();
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
  if (json['likeStatus'] != null) {
    data.likeStatus = json['likeStatus']?.toString();
  }
  if (json['likeNumber'] != null) {
    data.likeNumber = json['likeNumber']?.toInt();
  }
  return data;
}

Map<String, dynamic> discoverItemDetailDataToJson(
    DiscoverItemDetailData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['title'] = entity.title;
  data['imageUrl'] = entity.imageUrl;
  data['createCommercialOid'] = entity.createCommercialOid;
  data['createCommercialName'] = entity.createCommercialName;
  data['createUserOid'] = entity.createUserOid;
  data['createUserName'] = entity.createUserName;
  data['createTime'] = entity.createTime;
  data['updateCommercialOid'] = entity.updateCommercialOid;
  data['updateCommercialName'] = entity.updateCommercialName;
  data['updateUserOid'] = entity.updateUserOid;
  data['updateUserName'] = entity.updateUserName;
  data['updateTime'] = entity.updateTime;
  data['context'] = entity.context;
  data['collectionStatus'] = entity.collectionStatus;
  data['collectionNumber'] = entity.collectionNumber;
  data['likeStatus'] = entity.likeStatus;
  data['likeNumber'] = entity.likeNumber;
  return data;
}

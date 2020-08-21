import 'package:neng/entity/discover_list_entity.dart';

discoverListEntityFromJson(DiscoverListEntity data, Map<String, dynamic> json) {
  if (json['total'] != null) {
    data.total = json['total']?.toInt();
  }
  if (json['message'] != null) {
    data.message = json['message'];
  }
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['rows'] != null) {
    data.rows = new List<DiscoverListRow>();
    (json['rows'] as List).forEach((v) {
      data.rows.add(new DiscoverListRow().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> discoverListEntityToJson(DiscoverListEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['total'] = entity.total;
  data['message'] = entity.message;
  data['code'] = entity.code;
  if (entity.rows != null) {
    data['rows'] = entity.rows.map((v) => v.toJson()).toList();
  }
  return data;
}

discoverListRowFromJson(DiscoverListRow data, Map<String, dynamic> json) {
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
    data.createCommercialOid = json['createCommercialOid']?.toString();
  }
  if (json['createCommercialName'] != null) {
    data.createCommercialName = json['createCommercialName']?.toString();
  }
  if (json['createUserOid'] != null) {
    data.createUserOid = json['createUserOid']?.toString();
  }
  if (json['createUserName'] != null) {
    data.createUserName = json['createUserName']?.toString();
  }
  if (json['createTime'] != null) {
    data.createTime = json['createTime']?.toString();
  }
  if (json['updateCommercialOid'] != null) {
    data.updateCommercialOid = json['updateCommercialOid']?.toString();
  }
  if (json['updateCommercialName'] != null) {
    data.updateCommercialName = json['updateCommercialName']?.toString();
  }
  if (json['updateUserOid'] != null) {
    data.updateUserOid = json['updateUserOid']?.toString();
  }
  if (json['updateUserName'] != null) {
    data.updateUserName = json['updateUserName']?.toString();
  }
  if (json['updateTime'] != null) {
    data.updateTime = json['updateTime']?.toString();
  }
  if (json['auditStatus'] != null) {
    data.auditStatus = json['auditStatus']?.toString();
  }
  if (json['blackStatus'] != null) {
    data.blackStatus = json['blackStatus']?.toString();
  }
  if (json['status'] != null) {
    data.status = json['status']?.toString();
  }
  return data;
}

Map<String, dynamic> discoverListRowToJson(DiscoverListRow entity) {
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
  data['auditStatus'] = entity.auditStatus;
  data['blackStatus'] = entity.blackStatus;
  data['status'] = entity.status;
  return data;
}

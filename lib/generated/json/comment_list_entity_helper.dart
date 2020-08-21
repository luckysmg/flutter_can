import 'package:neng/entity/comment_list_entity.dart';

commentListEntityFromJson(CommentListEntity data, Map<String, dynamic> json) {
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
    data.rows = new List<CommantListRows>();
    (json['rows'] as List).forEach((v) {
      data.rows.add(new CommantListRows().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> commentListEntityToJson(CommentListEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['total'] = entity.total;
  if (entity.rows != null) {
    data['rows'] = entity.rows.map((v) => v.toJson()).toList();
  }
  return data;
}

commantListRowsFromJson(CommantListRows data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['bid'] != null) {
    data.bid = json['bid']?.toString();
  }
  if (json['type'] != null) {
    data.type = json['type']?.toString();
  }
  if (json['uid'] != null) {
    data.uid = json['uid']?.toString();
  }
  if (json['nickName'] != null) {
    data.nickName = json['nickName']?.toString();
  }
  if (json['descript'] != null) {
    data.descript = json['descript']?.toString();
  }
  if (json['createTime'] != null) {
    data.createTime = json['createTime']?.toString();
  }
  if (json['headImageUrl'] != null) {
    data.headImageUrl = json['headImageUrl']?.toString();
  }
  return data;
}

Map<String, dynamic> commantListRowsToJson(CommantListRows entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['bid'] = entity.bid;
  data['type'] = entity.type;
  data['uid'] = entity.uid;
  data['nickName'] = entity.nickName;
  data['descript'] = entity.descript;
  data['createTime'] = entity.createTime;
  data['headImageUrl'] = entity.headImageUrl;
  return data;
}

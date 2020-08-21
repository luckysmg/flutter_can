import 'package:neng/entity/knowledge_list_entity.dart';

knowledgeListEntityFromJson(
    KnowledgeListEntity data, Map<String, dynamic> json) {
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
    data.rows = new List<KnowledgeListRow>();
    (json['rows'] as List).forEach((v) {
      data.rows.add(new KnowledgeListRow().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> knowledgeListEntityToJson(KnowledgeListEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['total'] = entity.total;
  if (entity.rows != null) {
    data['rows'] = entity.rows.map((v) => v.toJson()).toList();
  }
  return data;
}

knowledgeListRowFromJson(KnowledgeListRow data, Map<String, dynamic> json) {
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
  if (json['createTime'] != null) {
    data.createTime = json['createTime']?.toString();
  }
  return data;
}

Map<String, dynamic> knowledgeListRowToJson(KnowledgeListRow entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['discoverCategoryOid'] = entity.discoverCategoryOid;
  data['title'] = entity.title;
  data['subtitle'] = entity.subtitle;
  data['img'] = entity.img;
  data['notice'] = entity.notice;
  data['userOid'] = entity.userOid;
  data['nickName'] = entity.nickName;
  data['createTime'] = entity.createTime;
  return data;
}

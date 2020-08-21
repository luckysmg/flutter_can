import 'package:neng/entity/collection_class_entity.dart';

collectionClassEntityFromJson(
    CollectionClassEntity data, Map<String, dynamic> json) {
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
    data.rows = new List<CollectionClassRow>();
    (json['rows'] as List).forEach((v) {
      data.rows.add(new CollectionClassRow().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> collectionClassEntityToJson(CollectionClassEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['total'] = entity.total;
  if (entity.rows != null) {
    data['rows'] = entity.rows.map((v) => v.toJson()).toList();
  }
  return data;
}

collectionClassRowFromJson(CollectionClassRow data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['curriculumOid'] != null) {
    data.curriculumOid = json['curriculumOid']?.toString();
  }
  if (json['uid'] != null) {
    data.uid = json['uid']?.toString();
  }
  if (json['addingTime'] != null) {
    data.addingTime = json['addingTime']?.toString();
  }
  if (json['curriculumTitle'] != null) {
    data.curriculumTitle = json['curriculumTitle']?.toString();
  }
  if (json['curriculumPrice'] != null) {
    data.curriculumPrice = json['curriculumPrice']?.toString();
  }
  if (json['curriculumDiscountPrice'] != null) {
    data.curriculumDiscountPrice = json['curriculumDiscountPrice']?.toString();
  }
  if (json['beginEnlistTime'] != null) {
    data.beginEnlistTime = json['beginEnlistTime']?.toString();
  }
  if (json['endEnlistTime'] != null) {
    data.endEnlistTime = json['endEnlistTime']?.toString();
  }
  if (json['curriculumCommercialOid'] != null) {
    data.curriculumCommercialOid = json['curriculumCommercialOid']?.toString();
  }
  if (json['curriculumCommercialName'] != null) {
    data.curriculumCommercialName =
        json['curriculumCommercialName']?.toString();
  }
  if (json['curriculumAddress'] != null) {
    data.curriculumAddress = json['curriculumAddress']?.toString();
  }
  return data;
}

Map<String, dynamic> collectionClassRowToJson(CollectionClassRow entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['curriculumOid'] = entity.curriculumOid;
  data['uid'] = entity.uid;
  data['addingTime'] = entity.addingTime;
  data['curriculumTitle'] = entity.curriculumTitle;
  data['curriculumPrice'] = entity.curriculumPrice;
  data['curriculumDiscountPrice'] = entity.curriculumDiscountPrice;
  data['beginEnlistTime'] = entity.beginEnlistTime;
  data['endEnlistTime'] = entity.endEnlistTime;
  data['curriculumCommercialOid'] = entity.curriculumCommercialOid;
  data['curriculumCommercialName'] = entity.curriculumCommercialName;
  data['curriculumAddress'] = entity.curriculumAddress;
  return data;
}

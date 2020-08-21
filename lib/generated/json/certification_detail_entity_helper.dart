import 'package:neng/entity/certification_detail_entity.dart';

certificationDetailEntityFromJson(
    CertificationDetailEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new CertificationDetailData().fromJson(json['data']);
  }
  if (json['message'] != null) {
    data.message = json['message'];
  }
  return data;
}

Map<String, dynamic> certificationDetailEntityToJson(
    CertificationDetailEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  data['message'] = entity.message;
  return data;
}

certificationDetailDataFromJson(
    CertificationDetailData data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid'];
  }
  if (json['certificationOid'] != null) {
    data.certificationOid = json['certificationOid']?.toString();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['introduce'] != null) {
    data.introduce = json['introduce']?.toString();
  }
  if (json['conditions'] != null) {
    data.conditions = json['conditions']?.toString();
  }
  if (json['subject'] != null) {
    data.subject = json['subject']?.toString();
  }
  if (json['notice'] != null) {
    data.notice = json['notice']?.toString();
  }
  if (json['method'] != null) {
    data.method = json['method']?.toString();
  }
  if (json['collectionStatus'] != null) {
    data.collectionStatus = json['collectionStatus']?.toString();
  }
  if (json['collectionNumber'] != null) {
    data.collectionNumber = json['collectionNumber']?.toInt();
  }
  if (json['schedules'] != null) {
    data.schedules = new List<CertificationDetailDataSchedule>();
    (json['schedules'] as List).forEach((v) {
      data.schedules.add(new CertificationDetailDataSchedule().fromJson(v));
    });
  }
  if (json['curriculums'] != null) {
    data.curriculums = new List<CertificationDetailDataCurriculum>();
    (json['curriculums'] as List).forEach((v) {
      data.curriculums.add(new CertificationDetailDataCurriculum().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> certificationDetailDataToJson(
    CertificationDetailData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['certificationOid'] = entity.certificationOid;
  data['name'] = entity.name;
  data['introduce'] = entity.introduce;
  data['conditions'] = entity.conditions;
  data['subject'] = entity.subject;
  data['notice'] = entity.notice;
  data['method'] = entity.method;
  data['collectionStatus'] = entity.collectionStatus;
  data['collectionNumber'] = entity.collectionNumber;
  if (entity.schedules != null) {
    data['schedules'] = entity.schedules.map((v) => v.toJson()).toList();
  }
  if (entity.curriculums != null) {
    data['curriculums'] = entity.curriculums.map((v) => v.toJson()).toList();
  }
  return data;
}

certificationDetailDataScheduleFromJson(
    CertificationDetailDataSchedule data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['provinceOid'] != null) {
    data.provinceOid = json['provinceOid']?.toString();
  }
  if (json['provinceName'] != null) {
    data.provinceName = json['provinceName']?.toString();
  }
  if (json['beginEnlistTime'] != null) {
    data.beginEnlistTime = json['beginEnlistTime']?.toString();
  }
  if (json['endEnlistTime'] != null) {
    data.endEnlistTime = json['endEnlistTime']?.toString();
  }
  if (json['stageTime'] != null) {
    data.stageTime = json['stageTime']?.toString();
  }
  if (json['fee'] != null) {
    data.fee = json['fee']?.toDouble();
  }
  return data;
}

Map<String, dynamic> certificationDetailDataScheduleToJson(
    CertificationDetailDataSchedule entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['provinceOid'] = entity.provinceOid;
  data['provinceName'] = entity.provinceName;
  data['beginEnlistTime'] = entity.beginEnlistTime;
  data['endEnlistTime'] = entity.endEnlistTime;
  data['stageTime'] = entity.stageTime;
  data['fee'] = entity.fee;
  return data;
}

certificationDetailDataCurriculumFromJson(
    CertificationDetailDataCurriculum data, Map<String, dynamic> json) {
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
  if (json['stageTime'] != null) {
    data.stageTime = json['stageTime']?.toString();
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
  if (json['address'] != null) {
    data.address = json['address']?.toString();
  }
  if (json['beginEnlistTime'] != null) {
    data.beginEnlistTime = json['beginEnlistTime']?.toString();
  }
  if (json['endEnlistTime'] != null) {
    data.endEnlistTime = json['endEnlistTime']?.toString();
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
  return data;
}

Map<String, dynamic> certificationDetailDataCurriculumToJson(
    CertificationDetailDataCurriculum entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['title'] = entity.title;
  data['categoryOid'] = entity.categoryOid;
  data['imageUrl'] = entity.imageUrl;
  data['price'] = entity.price;
  data['discountPrice'] = entity.discountPrice;
  data['stageTime'] = entity.stageTime;
  data['commercialOid'] = entity.commercialOid;
  data['commercialName'] = entity.commercialName;
  data['provinceOid'] = entity.provinceOid;
  data['provinceName'] = entity.provinceName;
  data['cityOid'] = entity.cityOid;
  data['cityName'] = entity.cityName;
  data['districtOid'] = entity.districtOid;
  data['districtName'] = entity.districtName;
  data['address'] = entity.address;
  data['beginEnlistTime'] = entity.beginEnlistTime;
  data['endEnlistTime'] = entity.endEnlistTime;
  data['online'] = entity.online;
  data['offline'] = entity.offline;
  data['auditStatus'] = entity.auditStatus;
  data['shelfStatus'] = entity.shelfStatus;
  data['blackStatus'] = entity.blackStatus;
  data['status'] = entity.status;
  return data;
}

import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class CertificationDetailEntity with JsonConvert<CertificationDetailEntity> {
  int code;
  CertificationDetailData data;
  dynamic message;
}

class CertificationDetailData with JsonConvert<CertificationDetailData> {
  dynamic oid;
  String certificationOid;
  String name;
  String introduce;
  String conditions;
  String subject;
  String notice;
  String method;
  String collectionStatus;
  int collectionNumber;
  List<CertificationDetailDataSchedule> schedules;
  List<CertificationDetailDataCurriculum> curriculums;
}

class CertificationDetailDataSchedule
    with JsonConvert<CertificationDetailDataSchedule> {
  String oid;
  String provinceOid;
  String provinceName;
  String beginEnlistTime;
  String endEnlistTime;
  String stageTime;
  double fee;
}

class CertificationDetailDataCurriculum
    with JsonConvert<CertificationDetailDataCurriculum> {
  String oid;
  String title;
  String categoryOid;
  String imageUrl;
  String price;
  String discountPrice;
  String stageTime;
  String commercialOid;
  String commercialName;
  String provinceOid;
  String provinceName;
  String cityOid;
  String cityName;
  String districtOid;
  String districtName;
  String address;
  String beginEnlistTime;
  String endEnlistTime;
  String online;
  String offline;
  String auditStatus;
  String shelfStatus;
  String blackStatus;
  String status;
}

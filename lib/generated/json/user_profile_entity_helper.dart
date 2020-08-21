import 'package:neng/entity/user_profile_entity.dart';

userProfileEntityFromJson(UserProfileEntity data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['nickName'] != null) {
    data.nickName = json['nickName']?.toString();
  }
  if (json['headImageUrl'] != null) {
    data.headImageUrl = json['headImageUrl']?.toString();
  }
  if (json['gender'] != null) {
    data.gender = json['gender']?.toString();
  }
  if (json['provinceCode'] != null) {
    data.provinceCode = json['provinceCode']?.toString();
  }
  if (json['provinceName'] != null) {
    data.provinceName = json['provinceName']?.toString();
  }
  if (json['cityCode'] != null) {
    data.cityCode = json['cityCode']?.toString();
  }
  if (json['cityName'] != null) {
    data.cityName = json['cityName']?.toString();
  }
  if (json['districtCode'] != null) {
    data.districtCode = json['districtCode']?.toString();
  }
  if (json['districtName'] != null) {
    data.districtName = json['districtName']?.toString();
  }
  if (json['addrDetail'] != null) {
    data.addrDetail = json['addrDetail']?.toString();
  }
  if (json['postalCode'] != null) {
    data.postalCode = json['postalCode']?.toString();
  }
  if (json['longitude'] != null) {
    data.longitude = json['longitude']?.toDouble();
  }
  if (json['latitude'] != null) {
    data.latitude = json['latitude']?.toDouble();
  }
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['message'] != null) {
    data.message = json['message']?.toString();
  }
  if (json['professionName'] != null) {
    data.professionName = json['professionName']?.toString();
  }
  if (json['professionCode'] != null) {
    data.professionCode = json['professionCode']?.toString();
  }
  if (json['passInited'] != null) {
    data.passInited = json['passInited']?.toString();
  }
  if (json['galaxyCode'] != null) {
    data.galaxyCode = json['galaxyCode']?.toString();
  }
  if (json['galaxyName'] != null) {
    data.galaxyName = json['galaxyName']?.toString();
  }
  return data;
}

Map<String, dynamic> userProfileEntityToJson(UserProfileEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['nickName'] = entity.nickName;
  data['headImageUrl'] = entity.headImageUrl;
  data['gender'] = entity.gender;
  data['provinceCode'] = entity.provinceCode;
  data['provinceName'] = entity.provinceName;
  data['cityCode'] = entity.cityCode;
  data['cityName'] = entity.cityName;
  data['districtCode'] = entity.districtCode;
  data['districtName'] = entity.districtName;
  data['addrDetail'] = entity.addrDetail;
  data['postalCode'] = entity.postalCode;
  data['longitude'] = entity.longitude;
  data['latitude'] = entity.latitude;
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['professionName'] = entity.professionName;
  data['professionCode'] = entity.professionCode;
  data['passInited'] = entity.passInited;
  data['galaxyCode'] = entity.galaxyCode;
  data['galaxyName'] = entity.galaxyName;
  return data;
}

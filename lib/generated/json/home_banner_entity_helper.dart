import 'package:neng/entity/home_banner_entity.dart';

homeBannerEntityFromJson(HomeBannerEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new List<HomeBannerData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new HomeBannerData().fromJson(v));
    });
  }
  if (json['message'] != null) {
    data.message = json['message'];
  }
  return data;
}

Map<String, dynamic> homeBannerEntityToJson(HomeBannerEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  data['message'] = entity.message;
  return data;
}

homeBannerDataFromJson(HomeBannerData data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['title'] != null) {
    data.title = json['title']?.toString();
  }
  if (json['imageUrl'] != null) {
    data.imageUrl = json['imageUrl']?.toString();
  }
  if (json['url'] != null) {
    data.url = json['url'];
  }
  if (json['orderNum'] != null) {
    data.orderNum = json['orderNum']?.toInt();
  }
  if (json['createTime'] != null) {
    data.createTime = json['createTime'];
  }
  if (json['status'] != null) {
    data.status = json['status']?.toString();
  }
  return data;
}

Map<String, dynamic> homeBannerDataToJson(HomeBannerData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['title'] = entity.title;
  data['imageUrl'] = entity.imageUrl;
  data['url'] = entity.url;
  data['orderNum'] = entity.orderNum;
  data['createTime'] = entity.createTime;
  data['status'] = entity.status;
  return data;
}

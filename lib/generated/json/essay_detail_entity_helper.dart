import 'package:neng/entity/essay_detail_entity.dart';

essayDetailEntityFromJson(EssayDetailEntity data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['communityOid'] != null) {
    data.communityOid = json['communityOid']?.toString();
  }
  if (json['content'] != null) {
    data.content = json['content']?.toString();
  }
  if (json['userOid'] != null) {
    data.userOid = json['userOid']?.toString();
  }
  if (json['nickName'] != null) {
    data.nickName = json['nickName']?.toString();
  }
  if (json['headImageUrl'] != null) {
    data.headImageUrl = json['headImageUrl']?.toString();
  }
  if (json['imgOne'] != null) {
    data.imgOne = json['imgOne']?.toString();
  }
  if (json['imgTwo'] != null) {
    data.imgTwo = json['imgTwo']?.toString();
  }
  if (json['imgThree'] != null) {
    data.imgThree = json['imgThree'];
  }
  if (json['imgFour'] != null) {
    data.imgFour = json['imgFour'];
  }
  if (json['imgFive'] != null) {
    data.imgFive = json['imgFive'];
  }
  if (json['imgSix'] != null) {
    data.imgSix = json['imgSix'];
  }
  if (json['imgSeven'] != null) {
    data.imgSeven = json['imgSeven'];
  }
  if (json['imgEight'] != null) {
    data.imgEight = json['imgEight'];
  }
  if (json['imgNine'] != null) {
    data.imgNine = json['imgNine'];
  }
  if (json['createTime'] != null) {
    data.createTime = json['createTime']?.toString();
  }
  if (json['updateTime'] != null) {
    data.updateTime = json['updateTime']?.toString();
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

Map<String, dynamic> essayDetailEntityToJson(EssayDetailEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['communityOid'] = entity.communityOid;
  data['content'] = entity.content;
  data['userOid'] = entity.userOid;
  data['nickName'] = entity.nickName;
  data['headImageUrl'] = entity.headImageUrl;
  data['imgOne'] = entity.imgOne;
  data['imgTwo'] = entity.imgTwo;
  data['imgThree'] = entity.imgThree;
  data['imgFour'] = entity.imgFour;
  data['imgFive'] = entity.imgFive;
  data['imgSix'] = entity.imgSix;
  data['imgSeven'] = entity.imgSeven;
  data['imgEight'] = entity.imgEight;
  data['imgNine'] = entity.imgNine;
  data['createTime'] = entity.createTime;
  data['updateTime'] = entity.updateTime;
  data['collectionStatus'] = entity.collectionStatus;
  data['collectionNumber'] = entity.collectionNumber;
  data['likeStatus'] = entity.likeStatus;
  data['likeNumber'] = entity.likeNumber;
  return data;
}

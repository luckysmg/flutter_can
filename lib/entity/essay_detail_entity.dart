import 'package:neng/generated/json/base/json_convert_content.dart';

class EssayDetailEntity with JsonConvert<EssayDetailEntity> {
  String oid;
  String communityOid;
  String content;
  String userOid;
  String nickName;
  String headImageUrl;
  String imgOne;
  String imgTwo;
  dynamic imgThree;
  dynamic imgFour;
  dynamic imgFive;
  dynamic imgSix;
  dynamic imgSeven;
  dynamic imgEight;
  dynamic imgNine;
  String createTime;
  String updateTime;
  String collectionStatus;
  int collectionNumber;
  String likeStatus;
  int likeNumber;
}

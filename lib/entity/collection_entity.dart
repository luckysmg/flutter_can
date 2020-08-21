import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class CollectionEntity with JsonConvert<CollectionEntity> {
  int code;
  dynamic message;
  dynamic collectionNumber;
}

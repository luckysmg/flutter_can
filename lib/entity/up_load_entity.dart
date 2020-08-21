import 'package:neng/generated/json/base/json_convert_content.dart';

class UpLoadEntity with JsonConvert<UpLoadEntity> {
  List<UpLoadFile> files;
}

class UpLoadFile with JsonConvert<UpLoadFile> {
  String oid;
  String field;
  String md5;
  String filename;
  String suffix;
  String storage;
  String displaySize;
  int size;
  String url;
  String uploadTime;
  String groups;
  String type;
}

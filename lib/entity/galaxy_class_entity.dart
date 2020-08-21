import 'package:neng/generated/json/base/json_convert_content.dart';

class GalaxyClassEntity with JsonConvert<GalaxyClassEntity> {
  int code;
  dynamic message;
  int total;
  List<GalaxyClassRow> rows;
}

class GalaxyClassRow with JsonConvert<GalaxyClassRow> {
  String oid;
  String name;
  String img;
}

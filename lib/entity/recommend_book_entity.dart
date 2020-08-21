import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class RecommendBookEntity with JsonConvert<RecommendBookEntity> {
  int code;
  dynamic message;
  int total;
  List<RecommandBookRows> rows;
}

class RecommandBookRows with JsonConvert<RecommandBookRows> {
  String oid;
  String name;
  String cover;
  String author;
  String publishDate;
  String publisher;
  String isbn;
  int pubTimes;
  double price;
  String status;
}

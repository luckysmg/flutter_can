import 'package:neng/generated/json/base/json_convert_content.dart';
import 'package:neng/generated/json/base/json_filed.dart';

class BookDetailEntity with JsonConvert<BookDetailEntity> {
  int code;
  BookDetailData data;
  dynamic message;
}

class BookDetailData with JsonConvert<BookDetailData> {
  String oid;
  String name;
  String cover;
  String author;
  String publishDate;
  String publisher;
  String isbn;
  dynamic pubTimes;
  double price;
  dynamic status;
  String introduction;
  String collectionStatus;
  int collectionNumber;
}

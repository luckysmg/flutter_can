import 'package:neng/entity/book_detail_entity.dart';

bookDetailEntityFromJson(BookDetailEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new BookDetailData().fromJson(json['data']);
  }
  if (json['message'] != null) {
    data.message = json['message'];
  }
  return data;
}

Map<String, dynamic> bookDetailEntityToJson(BookDetailEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  data['message'] = entity.message;
  return data;
}

bookDetailDataFromJson(BookDetailData data, Map<String, dynamic> json) {
  if (json['oid'] != null) {
    data.oid = json['oid']?.toString();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['cover'] != null) {
    data.cover = json['cover']?.toString();
  }
  if (json['author'] != null) {
    data.author = json['author']?.toString();
  }
  if (json['publishDate'] != null) {
    data.publishDate = json['publishDate']?.toString();
  }
  if (json['publisher'] != null) {
    data.publisher = json['publisher']?.toString();
  }
  if (json['isbn'] != null) {
    data.isbn = json['isbn']?.toString();
  }
  if (json['pubTimes'] != null) {
    data.pubTimes = json['pubTimes'];
  }
  if (json['price'] != null) {
    data.price = json['price']?.toDouble();
  }
  if (json['status'] != null) {
    data.status = json['status'];
  }
  if (json['introduction'] != null) {
    data.introduction = json['introduction']?.toString();
  }
  if (json['collectionStatus'] != null) {
    data.collectionStatus = json['collectionStatus']?.toString();
  }
  if (json['collectionNumber'] != null) {
    data.collectionNumber = json['collectionNumber']?.toInt();
  }
  return data;
}

Map<String, dynamic> bookDetailDataToJson(BookDetailData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['oid'] = entity.oid;
  data['name'] = entity.name;
  data['cover'] = entity.cover;
  data['author'] = entity.author;
  data['publishDate'] = entity.publishDate;
  data['publisher'] = entity.publisher;
  data['isbn'] = entity.isbn;
  data['pubTimes'] = entity.pubTimes;
  data['price'] = entity.price;
  data['status'] = entity.status;
  data['introduction'] = entity.introduction;
  data['collectionStatus'] = entity.collectionStatus;
  data['collectionNumber'] = entity.collectionNumber;
  return data;
}

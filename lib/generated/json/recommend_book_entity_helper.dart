import 'package:neng/entity/recommend_book_entity.dart';

recommendBookEntityFromJson(
    RecommendBookEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['message'] != null) {
    data.message = json['message'];
  }
  if (json['total'] != null) {
    data.total = json['total']?.toInt();
  }
  if (json['rows'] != null) {
    data.rows = new List<RecommandBookRows>();
    (json['rows'] as List).forEach((v) {
      data.rows.add(new RecommandBookRows().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> recommendBookEntityToJson(RecommendBookEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['total'] = entity.total;
  if (entity.rows != null) {
    data['rows'] = entity.rows.map((v) => v.toJson()).toList();
  }
  return data;
}

recommandBookRowsFromJson(RecommandBookRows data, Map<String, dynamic> json) {
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
    data.pubTimes = json['pubTimes']?.toInt();
  }
  if (json['price'] != null) {
    data.price = json['price']?.toDouble();
  }
  if (json['status'] != null) {
    data.status = json['status']?.toString();
  }
  return data;
}

Map<String, dynamic> recommandBookRowsToJson(RecommandBookRows entity) {
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
  return data;
}

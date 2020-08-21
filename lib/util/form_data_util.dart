import 'dart:typed_data';

import 'package:dio/dio.dart';

class FormDataUtil {
  static FormData parseSingleImageFormData(dynamic img, String fileName) {
    MultipartFile multipartFile = MultipartFile.fromBytes(img);
    var param = FormData.fromMap({'storage': 'OSS', fileName: multipartFile});
    return param;
  }
}

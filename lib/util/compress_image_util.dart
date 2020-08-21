import 'package:flutter_image_compress/flutter_image_compress.dart';

class CompressImageUtil {
  ///压缩图片
  static Future<dynamic> getCompressImage(dynamic img) async {
    var list = await FlutterImageCompress.compressWithList(img,
        quality: 20, format: CompressFormat.jpeg);
    return list;
  }
}

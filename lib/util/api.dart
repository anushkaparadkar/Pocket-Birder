import 'package:dio/dio.dart';
import 'dart:io';
import 'package:path/path.dart';

class API {
  static final String url = '';
  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );
  static final service = Dio(opts);

  const API();

  Future<String> predictBird(File image) async {
    FormData data = new FormData.from(
        {"file": new UploadFileInfo(image, basename(image.path))});
    Response res = await service.post(
      "/predict",
      data: data,
      options: Options(
        method: 'POST',
      ),
    );
    String prediction = res.data.toString();
    return prediction;
  }
}

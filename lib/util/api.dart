import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:async';

class API {
  static BaseOptions opts = BaseOptions(
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );
  static final service = Dio(opts);

  const API();

  Future<String> predictBird(File image) async {
    FormData data =
        FormData.from({"file": new UploadFileInfo(image, image.path)});
    Response res = await service.post(
      "http://0faff8b7.ngrok.io/bird",
      data: data,
      options: Options(
        method: 'POST',
      ),
    );
    String prediction = res.data['result'].toString();
    return prediction;
  }

  Future<Map> getBirdDetails(String name) async {
    String url = 'https://www.xeno-canto.org/api/2/recordings?query=' + name;
    Response res = await service.get(url, options: Options(method: 'GET'));
    List data = res.data['recordings'];
    Map bird = {
      "name": data[0]['en'],
      "scientificName": data[0]['gen'] + ' ' + data[0]['sp'],
      "commonLocation": data[0]['cnt'],
      "call": data[0]['file'].substring(
        2,
      ),
      "lat": data[0]['lat'],
      "lng": data[0]['lng']
    };
    return bird;
  }

  Future<String> getAudio(String url) async {
    Response res = await service.get(url,
        options: Options(
          method: 'GET',
          followRedirects: true,
        ));
    print(res.redirects.toString());
    return 'DUMMY!';
  }
}

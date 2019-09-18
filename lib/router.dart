import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:pocket_birder_x/views/auth.dart';
import 'package:pocket_birder_x/views/features.dart';
import 'package:pocket_birder_x/views/home.dart';

class BirdRouter {
  static Router router = Router();

  static Handler _home =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return HomePage();
  });
  static Handler _auth =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return LoginPage();
  });
  static Handler _features =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return Features(
      images: [
        'assets/images/identification.png',
        'assets/images/location.jpg',
        'assets/images/song.jpg'
      ],
      titles: ['Identification', 'Location', 'Call'],
    );
  });

  static void setupRouter() {
    router.define('home', handler: _home);
    router.define('features', handler: _features);
    router.define('auth', handler: _auth);
  }
}

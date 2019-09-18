import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:pocket_birder_x/views/features.dart';
import 'package:pocket_birder_x/views/home.dart';

class BirdRouter {
  static Router router = Router();

  static Handler _home =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return HomePage();
  });
  static Handler _features =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return Features(
      images: [],
      titles: [],
    );
  });

  static void setupRouter() {
    router.define('home', handler: _home);
    router.define('features', handler: _features);
  }
}
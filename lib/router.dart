import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:pocket_birder_x/components/root.dart';
import 'package:pocket_birder_x/views/auth.dart';
import 'package:pocket_birder_x/views/features.dart';
import 'package:pocket_birder_x/views/home.dart';
import 'package:pocket_birder_x/views/snap-image.dart';

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

  static Handler _snap =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return Root(
        child: Snap(
      value: int.parse(params['value'][0]),
    ));
  });

  static Handler _features =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return Root(
      child: Features(),
    );
  });

  static void setupRouter() {
    router.define('home', handler: _home);
    router.define('features', handler: _features);
    router.define('auth', handler: _auth);
    router.define('snap/:value', handler: _snap);
  }
}

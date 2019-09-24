import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:pocket_birder_x/components/root.dart';
import 'package:pocket_birder_x/views/auth.dart';
import 'package:pocket_birder_x/views/bird_details.dart';
import 'package:pocket_birder_x/views/features.dart';
import 'package:pocket_birder_x/views/home.dart';
import 'package:pocket_birder_x/views/snap-image.dart';
import 'package:pocket_birder_x/views/splash.dart';

class BirdRouter {
  static Router router = Router();

  static Handler _home =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return Root(
      child: HomePage(
          // id: params['id'][0],
          ),
    );
  });

  static Handler _splash =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return Landing();
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

  static Handler _details =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return Root(
      child: Details(
        name: params['name'][0],
      ),
    );
  });

  static void setupRouter() {
    router.define('splash', handler: _splash);
    router.define('home/:id', handler: _home);
    router.define('features', handler: _features);
    router.define('details/:name', handler: _details);
    router.define('auth', handler: _auth);
    router.define('snap/:value', handler: _snap);
  }
}

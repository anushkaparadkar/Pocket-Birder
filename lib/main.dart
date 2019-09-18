import 'package:flutter/material.dart';
import 'package:pocket_birder_x/router.dart';

void main() {
  BirdRouter.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'auth',
      onGenerateRoute: BirdRouter.router.generator,
    );
  }
}

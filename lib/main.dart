import 'package:flutter/material.dart';
import 'package:pocket_birder_x/router.dart';
import 'package:pocket_birder_x/views/features.dart';

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
      home: Features(),
      onGenerateRoute: BirdRouter.router.generator,
    );
  }
}

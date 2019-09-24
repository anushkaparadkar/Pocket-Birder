import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pocket_birder_x/router.dart';
import 'package:provider/provider.dart';

void main() async {
  BirdRouter.setupRouter();
  runApp(Birder());
}

class Birder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        )
      ],
      child: MaterialApp(
        title: 'Pocket Birder',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.greenAccent,
          fontFamily: 'Montserrat',
        ),
        initialRoute: 'splash',
        onGenerateRoute: BirdRouter.router.generator,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

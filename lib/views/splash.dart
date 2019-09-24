import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pocket_birder_x/components/loader.dart';

class Landing extends StatefulWidget {
  Landing({Key key}) : super(key: key);

  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((currentUser) {
      if (currentUser == null) {
        Navigator.pushReplacementNamed(context, 'auth');
      } else {
        Navigator.pushReplacementNamed(context, 'home/${currentUser.uid}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Pocket Birder",
                style: TextStyle(
                  fontSize: 28,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/icon.png',
                  width: 100,
                  height: 100,
                ),
              ),
              CustomLoader(),
            ],
          ),
        ),
      ),
    );
  }
}

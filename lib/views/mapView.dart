import 'package:flutter/material.dart';

class MapView extends StatefulWidget {
  MapView({Key key}) : super(key: key);

  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Plan to plot the locations of the birds the user has given.")
          ],
        ),
      ),
    );
  }
}

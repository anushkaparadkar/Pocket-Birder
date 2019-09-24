import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String name;
  Details({Key key, this.name}) : super(key: key);

  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(this.widget.name),
    );
  }
}

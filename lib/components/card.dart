import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget content;
  final Color bgColor;

  CustomCard({this.content, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: new Stack(
        children: <Widget>[
          new Container(
            width: double.infinity,
            //height: 500,
            decoration: new BoxDecoration(
              color: bgColor,
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: new Offset(0.0, 10.0),
                  
                )
              ],
            ),
            child: content,
          )
        ],
      ),
    );
  }
}

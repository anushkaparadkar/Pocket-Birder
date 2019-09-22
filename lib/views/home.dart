import 'package:flutter/material.dart';

var greenColor = Color(0xff32a05f);
var darkGreenColor = Color(0xff279152);
var productImage = '';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(108.0)),
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                height: 100.0,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 100.0,
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          50,
                                    ),
                                  ],
                                ))
                          ],
                        )
                      ])),
            ),
          ],
        ));
  }
}

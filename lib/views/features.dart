import 'package:flutter/material.dart';
import 'package:pocket_birder_x/components/card.dart';
import 'package:snaplist/snaplist.dart';

class Features extends StatelessWidget {
  final List<String> images;
  final List<String> titles;

  const Features({Key key, this.images, this.titles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size cardSize = Size(300.0, 460.0);
    return SnapList(
      padding: EdgeInsets.only(
          left: (MediaQuery.of(context).size.width - cardSize.width) / 2),
      sizeProvider: (index, data) => cardSize,
      separatorProvider: (index, data) => Size(10.0, 10.0),
      builder: (context, index, data) {
        return CustomCard(
          bgColor: Colors.white,
          content: Text('Test'),
        );
      },
      count: 3,
    );
  }
}

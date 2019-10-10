import 'package:flutter/material.dart';
import 'package:pocket_birder_x/components/card.dart';
import 'package:pocket_birder_x/components/loader.dart';
import 'package:pocket_birder_x/models/user.dart';
import 'package:pocket_birder_x/util/db.dart';

class HomePage extends StatefulWidget {
  final String id;
  const HomePage({Key key, this.id}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user;
  bool isLoading = true;
  DatabaseService db = DatabaseService();

  @override
  void initState() {
    super.initState();
    db.getUser(this.widget.id).then((user) {
      setState(() {
        this.user = user;
        this.isLoading = false;
      });
    });
  }

  Widget _circleImage(String url) {
    return Container(
      width: 300,
      height: 300,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: new NetworkImage(url),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: this.isLoading
          ? Center(child: CustomLoader())
          : CustomCard(
              bgColor: Colors.grey.shade300,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _circleImage(this.user.image),
                  ),
                  Text(
                    this.user.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Chip(
                      elevation: 5,
                      label: Text(
                        "Birds Spotted: ${this.user.seenBirds.length}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      labelPadding: EdgeInsets.all(5),
                      backgroundColor: Theme.of(context).primaryColor,
                      avatar: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pocket_birder_x/components/card.dart';
import 'package:pocket_birder_x/components/loader.dart';
import 'package:pocket_birder_x/models/user.dart';
import 'package:pocket_birder_x/util/db.dart';
import 'package:intl/intl.dart';

class Logs extends StatefulWidget {
  @override
  _LogsState createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  bool isLoading = true;
  DatabaseService db = DatabaseService();
  User user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((fbUser) {
      db.getUser(fbUser.uid).then((user) {
        setState(() {
          this.user = user;
          this.isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: this.isLoading
          ? Center(child: CustomLoader())
          : CustomCard(
              bgColor: Colors.grey.shade200,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Bird Diary",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    height: 1,
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(5),
                        onTap: () => Navigator.pushNamed(
                            context,
                            'details/' +
                                this.user.getSeenBirds()[index]['name']),
                        title: Text(this.user.getSeenBirds()[index]['name']),
                        subtitle: Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              color: Colors.grey,
                            ),
                            Text(" Seen on " +
                                new DateFormat.yMMMEd('en_US')
                                    .add_jms()
                                    .format(DateTime.fromMillisecondsSinceEpoch(
                                        this
                                                .user
                                                .getSeenBirds()[index]['seenOn']
                                                .seconds *
                                            1000))
                                    .toString()),
                          ],
                        ),
                      );
                    },
                    itemCount: this.user.getSeenBirds().length,
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pocket_birder_x/components/card.dart';
import 'package:pocket_birder_x/models/user.dart';
import 'package:pocket_birder_x/util/db.dart';
import 'package:intl/intl.dart';

class Features extends StatefulWidget {
  @override
  _FeaturesState createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {
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
          ? Center(child: CircularProgressIndicator())
          : CustomCard(
              bgColor: Colors.grey.shade200,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Bird Diary",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Divider(),
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(5),
                        onTap: () => Navigator.pushNamed(
                            context,
                            'details/' +
                                this.user.getSeenBirds()[index]['name']),
                        title: Text(this.user.getSeenBirds()[index]['name']),
                        subtitle: Text("Seen on " +
                            new DateFormat.yMMMEd('en_US')
                                .add_jms()
                                .format(DateTime.fromMillisecondsSinceEpoch(this
                                        .user
                                        .getSeenBirds()[index]['seenOn']
                                        .seconds *
                                    1000))
                                .toString()),
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

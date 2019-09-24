import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pocket_birder_x/components/bottomBar.dart';

class Root extends StatefulWidget {
  final Widget child;

  const Root({Key key, this.child}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  FirebaseUser user;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((currUser) {
      setState(() {
        this.user = currUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _items = [
      {'icon': Icon(Icons.photo_camera), 'text': Text("Camera")},
      {'icon': Icon(Icons.photo), 'text': Text("Gallery")}
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pocket Birder",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: this.widget.child,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black26,
                ),
                itemCount: 2,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    title: _items[index]['text'],
                    leading: _items[index]['icon'],
                    onTap: () => Navigator.pushNamed(context, "snap/$index"),
                  ),
                ),
              );
            }),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FABBottomAppBar(
        notchedShape: CircularNotchedRectangle(),
        color: Colors.white,
        selectedColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        centerItemText: "Snap!",
        iconSize: 30,
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
          FABBottomAppBarItem(iconData: Icons.library_books, text: 'Logs'),
          FABBottomAppBarItem(iconData: Icons.location_on, text: 'Map'),
          FABBottomAppBarItem(iconData: Icons.exit_to_app, text: 'Logout'),
        ],
      ),
    );
  }

  void _selectedTab(int index) {
    print("Tab: $index");
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, 'home/${this.user.uid}');
        break;
      case 1:
        Navigator.pushNamed(context, 'logs');
        break;
      case 2:
        Navigator.pushNamed(context, 'map');
        break;
      case 3:
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, 'splash');
        break;
      default:
        print(index);
    }
  }
}

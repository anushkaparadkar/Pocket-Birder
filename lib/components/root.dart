import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class Root extends StatefulWidget {
  final Widget child;

  const Root({Key key, this.child}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
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
            color: Theme.of(context).accentColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
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
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.center,
        opacity: 0.2,
        currentIndex: currentIndex,
        onTap: changePage,
        elevation: 5,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.red,
            ),
            title: Text("Home"),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.music_note,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.music_note,
              color: Colors.red,
            ),
            title: Text("Sounds"),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.settings,
              color: Colors.red,
            ),
            title: Text("Location"),
          ),
        ],
      ),
    );
  }
}

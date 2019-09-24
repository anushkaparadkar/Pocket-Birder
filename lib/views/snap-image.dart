import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_birder_x/components/card.dart';
import 'package:pocket_birder_x/util/api.dart';

class Snap extends StatefulWidget {
  final int value;

  const Snap({this.value});

  @override
  _SnapState createState() => _SnapState();
}

class _SnapState extends State<Snap> {
  File _image;
  bool isLoading = true;
  String prediction = '';
  API server = API();

  @override
  initState() {
    super.initState();
    getImage(this.widget.value);
  }

  void predict() async {
    String res = await server.predictFood(this._image);
    setState(() {
      this.prediction = res;
      this.isLoading = false;
    });
  }

  void addToLog() {
    //TODO: Implement Firestore
    print("Added To Log!");
  }

  Future getImage(int value) async {
    switch (value) {
      case 0:
        var image = await ImagePicker.pickImage(source: ImageSource.camera);
        setState(() {
          _image = image;
        });
        break;
      case 1:
        var image = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
          _image = image;
        });
        break;
      default:
        print("Wrong Choice");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new CustomCard(
        bgColor: Colors.grey.shade200,
        content: new Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: _image == null
                    ? Text(
                        'No image selected!\nPlease snap your bird again!',
                        style: TextStyle(
                          color: Theme.of(context).errorColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Image.file(_image),
              ),
              Padding(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => this.predict(),
                      child: Text(
                        "Recogonize",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: this.isLoading
                          ? CircularProgressIndicator()
                          : Text(this.prediction),
                    )
                  ],
                ),
                padding: EdgeInsets.all(10),
              ),
              Padding(
                child: RaisedButton(
                  onPressed: () => this.addToLog(),
                  child: Text(
                    "Add To Log",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                padding: EdgeInsets.all(5),
              )
            ],
          ),
        ),
      ),
    );
  }
}

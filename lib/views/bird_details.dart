import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pocket_birder_x/components/card.dart';
import 'package:pocket_birder_x/components/loader.dart';
import 'package:pocket_birder_x/util/api.dart';
import 'package:audioplayers/audioplayers.dart';

class Details extends StatefulWidget {
  final String name;
  Details({Key key, this.name}) : super(key: key);

  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isLoading = true;
  Map bird;
  API service = API();
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  String audioUrl = '';
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _myLocation;

  @override
  void initState() {
    super.initState();
    service.getBirdDetails(this.widget.name).then((bird) {
      setState(() {
        this.bird = bird;
        this.isLoading = false;
        this._myLocation = CameraPosition(
          target: LatLng(
            double.parse(bird['lat']),
            double.parse(bird['lng']),
          ),
          zoom: 10,
        );
      });
    });
    initPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    advancedPlayer.stop();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  Widget _tab(List<Widget> children) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            slider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: children
                  .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _btn(String txt, IconData icon, VoidCallback onPressed) {
    return RaisedButton.icon(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      icon: Icon(
        icon,
        color: Theme.of(context).accentColor,
      ),
      label: Text(
        txt,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  Widget playAudio(String audioFile) {
    return _tab([
      _btn('Play', Icons.play_arrow, () => advancedPlayer.play(audioFile)),
      _btn('Stop', Icons.stop, () => advancedPlayer.stop()),
    ]);
  }

  Widget slider() {
    return Slider(
        activeColor: Theme.of(context).accentColor,
        inactiveColor: Theme.of(context).primaryColor,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: this.isLoading
          ? Center(
              child: CustomLoader(),
            )
          : CustomCard(
              bgColor: Colors.grey.shade200,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      this.bird['name'],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_right,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              "Scientific Name",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Icon(
                              Icons.arrow_left,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                        Text(
                          this.bird['scientificName'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 250,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: GoogleMap(
                      initialCameraPosition: _myLocation,
                      mapType: MapType.normal,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      markers: {
                        Marker(
                          markerId: MarkerId(this.bird['name']),
                          position: LatLng(
                            double.parse(this.bird['lat']),
                            double.parse(this.bird['lng']),
                          ),
                        ),
                      },
                      compassEnabled: true,
                      mapToolbarEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomGesturesEnabled: true,
                    ),
                  ),
                  playAudio(
                      'https://www.xeno-canto.org/sounds/uploaded/MDZVOPUOXU/XC486531-190704_02.red.eyed.vireo.indian.spring.farm.lance.benner.mp3'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Commonly found in " + this.bird['commonLocation']),
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

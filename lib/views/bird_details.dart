import 'package:flutter/material.dart';
import 'package:pocket_birder_x/components/card.dart';
import 'package:pocket_birder_x/util/api.dart';
import 'package:audioplayers/audio_cache.dart';
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
  String audioUrl;

  @override
  void initState() {
    super.initState();
    service.getBirdDetails(this.widget.name).then((bird) {
      setState(() {
        this.bird = bird;
        this.isLoading = false;
      });
    });
    initPlayer();
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
    service.getFinalString(audioFile).then((url) {
      setState(() {
        this.audioUrl = url;
      });
    });
    return _tab([
      _btn('Play', Icons.play_arrow, () => advancedPlayer.play(this.audioUrl)),
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
              child: CircularProgressIndicator(),
            )
          : CustomCard(
              bgColor: Colors.grey.shade200,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    this.bird['name'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Text(
                    "Scientific Name\n" + this.bird['scientificName'],
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(this.bird['lat'] + ' ' + this.bird['lng']),
                  Text(this.bird['commonLocation']),
                  playAudio(this.audioUrl),
                ],
              ),
            ),
    );
  }
}

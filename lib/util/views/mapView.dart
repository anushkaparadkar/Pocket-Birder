import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pocket_birder_x/components/loader.dart';
import 'package:pocket_birder_x/models/user.dart';
import 'package:pocket_birder_x/util/db.dart';
import 'package:location/location.dart';

class Maps extends StatefulWidget {
  const Maps({Key key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();
  bool isLoading = true;
  DatabaseService db = DatabaseService();
  User user;
  Location location = new Location();
  LocationData _currentLocation;

  @override
  void initState() {
    super.initState();
    this.getBirds();
  }

  Future<BitmapDescriptor> _createMarkerImageFromAsset(String iconPath) async {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor bitmapImage =
        await BitmapDescriptor.fromAssetImage(configuration, iconPath);
    return bitmapImage;
  }

  void getBirds() async {
    LocationData curr = await location.getLocation();
    Set<Marker> _markers = {};
    BitmapDescriptor bitmapImage =
        await _createMarkerImageFromAsset('assets/images/marker.png');
    FirebaseAuth.instance.currentUser().then((fbUser) {
      db.getUser(fbUser.uid).then((user) {
        for (var bird in user.getSeenBirds()) {
          _markers.add(
            Marker(
              markerId: MarkerId(bird['name'].toString()),
              icon: bitmapImage,
              infoWindow: InfoWindow(title: bird['name'].toString()),
              position: LatLng(
                bird['lat'],
                bird['lng'],
              ),
            ),
          );
        }
        setState(() {
          this.markers = _markers;
          this._currentLocation = curr;
          this.isLoading = false;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !isLoading
            ? Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GoogleMap(
                    mapToolbarEnabled: true,
                    zoomGesturesEnabled: true,
                    markers: markers,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(this._currentLocation.latitude,
                          this._currentLocation.longitude),
                      zoom: 1.0,
                    ),
                    mapType: MapType.normal,
                  ),
                ],
              )
            : CustomLoader(),
      ),
    );
  }
}

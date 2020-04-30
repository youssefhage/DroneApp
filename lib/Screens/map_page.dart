import 'package:aeroship/Core/Coordinates.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MapPage(),
      ),
    );

// const double CAMERA_ZOOM = 13;
// const double CAMERA_TILT = 0;
// const double CAMERA_BEARING = 30;
// const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
// const LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);

class MapPage extends StatefulWidget {
  static String id = "MapPage";

  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Set<Polyline> lines = {};

  List<Coordinates> listCoords = new List();

  // final databaseReference = Firestore.instance;

  // void getData() {
  //   databaseReference.collection("books").getDocuments().then(
  //     (QuerySnapshot snapshot) {
  //       snapshot.documents.forEach((f) => print('${f.data}}'));
  //     },
  //   );
  // }

  Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/driving_pin.png');
  }

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/destination_map_marker.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
    // lines.add(
    //   Polyline(
    //     points: [
    //       LatLng(12.988827, 77.472091),
    //       LatLng(12.980821, 77.470815),
    //       LatLng(12.969406, 77.471301)
    //     ],
    //     endCap: Cap.squareCap,
    //     geodesic: false,
    //     polylineId: PolylineId("line_one"),
    //   ),
    // );
    lines.add(
      Polyline(
        points: [
          LatLng(33.919198461961564, 35.65664830959883),
          LatLng(33.915754, 35.618627)
        ],
        color: Colors.red,
        polylineId: PolylineId("line_one"),
      ),
    );
  }

  double currentLongitude = 0;
  double currentLatitude = 0;

  void getCurrentLocation() async {
    Position currentLocator = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    if (mounted) {
      setState(
        () {
          currentLatitude = currentLocator.latitude;
          currentLongitude = currentLocator.longitude;
          print("Latitude: $currentLocator \nLongitude: $currentLongitude");
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // getCurrentLocation();
    // getData();
    LatLng pinPosition = LatLng(currentLatitude, currentLongitude);

    final CameraPosition _kGooglePlex =
        CameraPosition(target: pinPosition, zoom: 13);
    return StreamBuilder(
      // DocumentSnapshot snapshot= await Firestore.instance.collection('channels').document('567890').
      stream: Firestore.instance
          .collection('coordinates')
          .document('Receiver')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Text("No Data");
        }
        var userDocument = snapshot.data;

        return MaterialApp(
          title: 'Google Maps Polylines',
          home: Scaffold(
            body: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              markers: _markers,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                _markers.add(Marker(
                    markerId: MarkerId("<MARKER_ID>"),
                    position: pinPosition,
                    icon: pinLocationIcon));
              },
              polylines: {
                Polyline(
                  points: [
                    LatLng(currentLatitude, currentLongitude),
                    LatLng(userDocument["lat"], userDocument["lng"])
                  ],
                  color: Colors.red,
                  polylineId: PolylineId("line_one"),
                )
              },
            ),
          ),
        );
      },
    );
  }
}

import 'package:aeroship/Screens/send_to_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  static String id = "HomePage";
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: FlatButton(
                padding: const EdgeInsets.only(
                    top: 8.0, right: 25, left: 25, bottom: 8),
                child: Text(
                  "Request",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                color: Colors.greenAccent,
                onPressed: () async {
                  Position position = await Geolocator().getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  print(position);
                  Navigator.pushNamed(context, SendTo.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

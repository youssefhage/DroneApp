import 'package:aeroship/Screens/countdowntimer.dart';
import 'package:aeroship/Screens/map_page.dart';
import 'package:flutter/material.dart';

List page_delegates = [
  [
    "Please put item in container and verify all suitable conditions apply!",
    "CHECK"
  ],
  ["Drone is about to take off!", "GO"],
];

int counter = 0;

class ProcessQueue extends StatefulWidget {
  static String id = "ProcessQueue";
  ProcessQueue({Key key}) : super(key: key);

  @override
  _ProcessQueueState createState() => _ProcessQueueState();
}

class _ProcessQueueState extends State<ProcessQueue> {
  @override
  Widget build(BuildContext context) {
    String description = page_delegates[counter][0];
    String functionName = page_delegates[counter][1];
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Center(
              child: Text(
                "$description",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Center(
            child: FlatButton(
              onPressed: () {
                setState(() {
                  if (counter < 1) {
                    counter++;
                  } else {
                    Navigator.pushNamed(context, MapPage.id);
                    // Navigator.pushNamed(context, CountDownTimer.id);
                    counter = 0;
                  }
                });
              },
              child: Text(
                "$functionName",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 25, right: 25),
              color: Colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }
}

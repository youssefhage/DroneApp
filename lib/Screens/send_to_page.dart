import 'package:aeroship/Screens/delivery_time.dart';
import 'package:flutter/material.dart';

class SendTo extends StatefulWidget {
  static String id = "SendTo";
  SendTo({Key key}) : super(key: key);

  @override
  _SendToState createState() => _SendToState();
}

class _SendToState extends State<SendTo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send To"),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(left: 25, right: 25),
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
          Text(
            "Receiver Coordinates",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 32, top: 16.0, bottom: 8.0, right: 32),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter receiver Url, Coordinates...',
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
          Center(
            child: FlatButton(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 25, right: 25),
              color: Colors.greenAccent,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomDialog(
                    title: "Success",
                    description:
                        "The Drone will arrive in 5 min ONLY. By the time of blinking you'll be ready to send ;)",
                    buttonText: "Let's Play",
                  ),
                );
              },
              child: Text(
                "Confirm",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

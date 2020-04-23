import 'package:aeroship/Screens/countdowntimer.dart';
import 'package:aeroship/Screens/map_page.dart';
import 'package:aeroship/Screens/process_queue.dart';
import 'package:aeroship/Screens/send_to_page.dart';
import 'package:flutter/material.dart';

import 'Screens/home_page.dart';

//Test

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AeroShip',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(
              title: 'AeroShip',
            ),
        SendTo.id: (context) => SendTo(),
        ProcessQueue.id: (context) => ProcessQueue(),
        CountDownTimer.id: (context) => CountDownTimer(),
        MapPage.id: (context) => MapPage(),
      },
    );
  }
}

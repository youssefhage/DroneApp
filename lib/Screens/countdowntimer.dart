import 'package:flutter/material.dart';
import 'dart:math' as math;

class CountDownTimer extends StatefulWidget {
  static String id = "CountDownTimer";
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ThemeData themeData = Theme.of(context);
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return SafeArea(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          alignment: FractionalOffset.topCenter,
                          child: Text(
                            "Time till Drone Arrives",
                            style: TextStyle(color: Colors.black, fontSize: 35),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.center,
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: CustomPaint(
                                        painter: CustomTimerPainter(
                                      animation: controller,
                                      backgroundColor: Colors.red,
                                      color: Colors.greenAccent,
                                    )),
                                  ),
                                  Align(
                                    alignment: FractionalOffset.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Count Down Timer",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          timerString,
                                          style: TextStyle(
                                              fontSize: 112.0,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // AnimatedBuilder(
                        //     animation: controller,
                        //     builder: (context, child) {
                        //       return
                        // FloatingActionButton.extended(
                        //     onPressed: () {
                        //       if (controller.isAnimating)
                        //         controller.stop();
                        //       else {
                        //         controller.reverse(
                        //             from: controller.value == 0.0
                        //                 ? 1.0
                        //                 : controller.value);
                        //       }
                        //     },
                        //     icon: Icon(controller.isAnimating
                        //         ? Icons.pause
                        //         : Icons.play_arrow),
                        //     label: Text(
                        //         controller.isAnimating ? "Pause" : "Play"));
                        // }),
                      ],
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.topCenter,
                  //   child: Text(
                  //     "Time till Drone Arrives",
                  //     style: TextStyle(color: Colors.black),
                  //   ),
                  // ),
                ],
              ),
            );
          }),
    );
  }
}

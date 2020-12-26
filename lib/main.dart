import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sensors/sensors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(home: _PerspectiveZoomDemoState());
  }
}

class _PerspectiveZoomDemoState extends StatefulWidget {
  @override
  __PerspectiveZoomDemoStateState createState() =>
      __PerspectiveZoomDemoStateState();
}

class __PerspectiveZoomDemoStateState extends State<_PerspectiveZoomDemoState> {
  AccelerometerEvent acceleration;
  StreamSubscription<AccelerometerEvent> _streamSubscription;

  int planetMotionSensitivity = 10;
  int bgMotionSensitivity = 2;

  @override
  void initState() {
    _streamSubscription = accelerometerEvents.listen((event) {
      setState(() {
        acceleration = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(children: [
          Positioned(
            
            child: Align(
              child: Image.asset(
                "assets/images/bg.png",
                height: Get.height,
                fit: BoxFit.contain,
              ),
            ),
          ),
          AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              top: acceleration.y * planetMotionSensitivity * 2,
              bottom: acceleration.y * -planetMotionSensitivity * 2,
              left: acceleration.x * -planetMotionSensitivity,
              right: acceleration.x * planetMotionSensitivity,
              child: Align(
                child: Image.asset(
                  "assets/images/earth.png",
                  height: Get.height * 0.3,
                ),
              ),
            ),
        ]),
      ),
    );
  }
}

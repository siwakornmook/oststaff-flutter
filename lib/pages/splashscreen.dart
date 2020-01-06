import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacementNamed(context, '/authen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue[100],
        child: FlareActor(
          "assets/flare/heartbeat.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "Untitled",
        ),
      ),
    );
  }
}

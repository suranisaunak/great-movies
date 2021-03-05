import 'dart:async';

import 'package:flutter/material.dart';
import 'package:greatmovie/Utils/responsive.dart';
import 'package:greatmovie/Views/mobile/HomeScreen.dart';
import 'package:greatmovie/Views/tablet/TabHomeScreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    if (getDeviceType() == DeviceType.Phone) {
      Timer(
          Duration(seconds: 1),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen())));
    } else {
      Timer(
          Duration(seconds: 1),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => TabHomeScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.25,
              ),
              Container(
                  width: width * 0.4,
                  height: height * 0.4,
                  child: Image.asset(
                    "assets/images/splash.png",
                    fit: BoxFit.contain,
                  )),
              SizedBox(
                height: height * 0.2,
              ),
              Text(
                "Welcome to Great Movie",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

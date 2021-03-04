import 'dart:async';

import 'package:flutter/material.dart';
import 'package:greatmovie/Views/HomeScreen.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 1),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen())));
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

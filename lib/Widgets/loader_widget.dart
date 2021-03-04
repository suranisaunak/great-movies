import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: height * 0.25,
        ),
        Container(
            width: width * 0.3,
            height: height * 0.3,
            child: Image.asset(
              "assets/images/splash.png",
              fit: BoxFit.contain,
            )),
        SizedBox(
          height: height * 0.15,
        ),
        CircularProgressIndicator()
      ],
    ));
  }
}

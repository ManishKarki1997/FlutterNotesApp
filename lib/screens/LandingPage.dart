import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todoapp/screens/Home.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1000), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
        child: Column(
          children: <Widget>[
            Text(
              "Notes",
              style: TextStyle(
                color: Theme.of(context).accentColor,
                decoration: TextDecoration.none,
                fontFamily: "Raleway",
                fontWeight: FontWeight.bold,
                fontSize: 48.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Minimal note taking app.",
              style: Theme.of(context).primaryTextTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}

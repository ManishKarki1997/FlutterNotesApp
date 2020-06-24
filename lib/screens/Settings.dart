import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Color(0xff010001),
      child: Center(child: Text("Settings", style: TextStyle(color: Colors.white, decoration: TextDecoration.none,),),),
    );
  }
}
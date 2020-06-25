import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/notes_provider.dart';
import 'package:todoapp/screens/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NotesProvider(),
          child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          // primaryColor: Colors.black,
          primaryColor: Color(0xff010001),
          fontFamily: "Karla",
          accentColor: Color(0xff00171f),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/models/Note.dart';

class SingleNote extends StatelessWidget {

  final Note note;

  SingleNote({this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
          body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0,),
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(note.title, style: TextStyle(color: Colors.white, fontFamily: "Merriweather",fontWeight: FontWeight.bold, fontSize: 20.0, decoration: TextDecoration.none), ),
                // SizedBox(height: 10.0,),
                Text(DateFormat.MMMEd().format(note.createdAt), style: TextStyle(color: Colors.white70, fontFamily: "Karla",fontWeight: FontWeight.bold, fontSize: 14.0, decoration: TextDecoration.none, height: 1.4), ),
                SizedBox(height: 20.0,),
                Text(note.description, style: TextStyle(color: Colors.white, fontFamily: "Karla",fontWeight: FontWeight.bold, fontSize: 16.0, decoration: TextDecoration.none, height: 1.4), ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
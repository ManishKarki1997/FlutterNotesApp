import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Color(0xff010001),
      child: Center(child: Text("Add Notes", style: TextStyle(color: Colors.white, decoration: TextDecoration.none,),),),
    );
  }
}
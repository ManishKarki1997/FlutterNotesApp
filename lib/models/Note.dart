import 'package:flutter/material.dart';

class Note{
  String title;
  String description;
  DateTime createdAt;
  String noteColor;

  Note({@required this.title, @required this.description, @required this.createdAt, this.noteColor = "0xff00171f"});
  
}
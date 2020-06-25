import 'package:flutter/material.dart';

class Note{
  String title;
  String description;
  DateTime createdAt;
  Color noteColor;

  Note({@required this.title, @required this.description, @required this.createdAt, this.noteColor});
  
}
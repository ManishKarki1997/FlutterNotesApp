import 'dart:convert';

import 'package:flutter/material.dart';

class Note {
  String noteId;
  String title;
  String description;
  String createdAt;
  String noteColor;

  Note(
      {@required this.noteId,
      @required this.title,
      @required this.description,
      @required this.createdAt,
      this.noteColor});

  factory Note.fromJson(Map<String, dynamic> jsonData) {
    return Note(
      noteId: jsonData['noteId'],
      title: jsonData['title'],
      description: jsonData['description'],
      createdAt: jsonData['createdAt'],
      noteColor: jsonData['noteColor'],
    );
  }

  static Map<String, dynamic> toMap(Note note) => {
        'noteId': note.noteId,
        'title': note.title,
        'description': note.description,
        'createdAt': note.createdAt,
        'noteColor': note.noteColor
      };

  static String encodeNotes(List<Note> notes) => json.encode(
        notes.map<Map<String, dynamic>>((note) => Note.toMap(note)).toList(),
      );

  static List<Note> decodeNotes(String notes) =>
      (json.decode(notes) as List<dynamic>)
          .map<Note>((item) => Note.fromJson(item))
          .toList();
}

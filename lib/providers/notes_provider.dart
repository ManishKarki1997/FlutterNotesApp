import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:todoapp/models/Note.dart';

class NotesProvider with ChangeNotifier{

  final List<Note> _notes = [];

  // Getters
  UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);
  
  void addNote(Note note){
    _notes.add(note);
    notifyListeners();
  }
  
  void deleteNote(Note note){
    _notes.remove(note);
    notifyListeners();
  }

}
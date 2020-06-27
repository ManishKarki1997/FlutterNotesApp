import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/Note.dart';

class NotesProvider with ChangeNotifier{

  List<Note> _notes = [];

  // Getters
  // UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);
  List<Note> get notes => _notes;
  
  void addNote(Note note){
    _notes.add(note);
    savePreferences();
    notifyListeners();
  }
  
  void deleteNote(Note note){
    _notes.remove(note);
    setNotes(_notes); // i thought i  wouldn't need this. but without this, the app wouldn't update
    // notifyListeners();
    savePreferences();
  }

  void setNotes(List<Note> notes){
    _notes = notes;
    notifyListeners();
  }

  void updateNote(Note note){
    print(note.title);
    print(note.description);
    int noteIndex = _notes.indexWhere((n) => n.noteId == note.noteId);
    _notes[noteIndex].title = note.title;
    _notes[noteIndex].description = note.description;
    _notes[noteIndex].noteColor = note.noteColor;
    setNotes(_notes);
    savePreferences();
  }


  savePreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedNotes = Note.encodeNotes(_notes);
    prefs.setString('notes', encodedNotes);
  }

  loadPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedNotes = prefs.getString('notes');
    if(encodedNotes != null){
    var decodedNotes = Note.decodeNotes(encodedNotes);
      setNotes(decodedNotes);
    }
  }

  clearPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }



}
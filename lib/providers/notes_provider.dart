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

  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.grey.shade100,
    accentColor: Colors.grey.shade900,
    backgroundColor: Colors.white,
    buttonColor: Colors.black87,
    hoverColor: Colors.grey.shade600,
    primaryTextTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.black, decoration: TextDecoration.none,fontFamily: "Merriweather",fontWeight: FontWeight.bold, fontSize: 20.0,),
      subtitle1: TextStyle(color: Colors.black, decoration: TextDecoration.none,fontFamily: "Karla", fontSize: 14.0,),
      headline6: TextStyle(color: Colors.black, fontFamily: "Merriweather",fontWeight: FontWeight.bold, fontSize: 20.0, decoration: TextDecoration.none),
      // headline6: TextStyle(color: Colors.black, decoration: TextDecoration.none,fontFamily: "Merriweather",fontWeight: FontWeight.bold, fontSize: 20.0,),
    ),
    brightness: Brightness.light
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Color(0xff010001),
    // primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white, decoration: TextDecoration.none)),
    accentColor: Colors.white,
    backgroundColor: Color(0xff010001),
    buttonColor: Colors.grey.shade900,
    hoverColor: Colors.grey.shade800,
     primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.white, decoration: TextDecoration.none,fontFamily: "Raleway",fontWeight: FontWeight.bold, fontSize: 20.0,),
      subtitle1: TextStyle(color: Colors.white, decoration: TextDecoration.none,fontFamily: "Karla", fontSize: 16.0, height: 1.4)
      ),
    brightness: Brightness.dark,
    
    // visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  // ThemeData activeTheme = darkTheme;
  ThemeData activeTheme = lightTheme;
  bool darkThemePreferred = false;

  ThemeData get currentTheme => activeTheme;

  void toggleTheme(){
    activeTheme = currentTheme == darkTheme ? lightTheme : darkTheme;
    darkThemePreferred = currentTheme == darkTheme ? true : false;
    savePreferences();
    notifyListeners();
  }
  
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

  void setDarkTheme(bool value){
    darkThemePreferred = value;
    notifyListeners();
  }

  void updateNote(Note note){
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
    prefs.setBool('notes-app-theme', darkThemePreferred);
  }

  loadPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedNotes = prefs.getString('notes');
    bool savedThemeDark = prefs.getBool('notes-app-theme');
    savedThemeDark == true ? activeTheme = darkTheme : activeTheme = lightTheme; 
    setDarkTheme(savedThemeDark);
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
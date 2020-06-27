import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/notes_provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
  var notesProvider = Provider.of<NotesProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Color(0xff010001),
      child: Center(
        child: GestureDetector(
          onTap: (){
            notesProvider.clearPreferences();
          },
                  child: Text("Settings", style: TextStyle(color: Colors.white, decoration: TextDecoration.none,)
          ,),
        )
      ,),
    );
  }
}
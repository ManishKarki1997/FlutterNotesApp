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
      color: notesProvider.activeTheme.primaryColor,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text(
                  "Toggle Theme",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => {notesProvider.toggleTheme()},
                color: Theme.of(context).buttonColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/Note.dart';
import 'package:todoapp/providers/notes_provider.dart';

class SingleNote extends StatefulWidget {

  final Note note;
  final bool editMode;

  SingleNote({this.note, this.editMode});

  @override
  _SingleNoteState createState() => _SingleNoteState();
}

class _SingleNoteState extends State<SingleNote> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  String title;
  String description;
  Color noteColor;
  int titleLength = 200;
  Color _tempShadeColor;
  Color _shadeColor;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  } 

  @override
  void initState() {
    super.initState();
    title = widget.note.title;
    description = widget.note.description;
    _shadeColor = Color(int.parse(widget.note.noteColor.substring(6,16)));
  }

  @override
  Widget build(BuildContext context) {

    void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: Text('Cancel'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('Choose'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _shadeColor = _tempShadeColor);
              
              },
            ),
          ],
        );
      },
    );
  }

  void _openColorPicker() async {
    _openDialog(
      "Note Background Color",
      MaterialColorPicker(
        selectedColor: _shadeColor,
        onColorChange: (color) => setState(() => _tempShadeColor = color),
        onBack: () => print("Back button pressed"),
      ),
    );
  }



    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Notes"),
      ),
          body: SafeArea(
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0,),
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: widget.editMode == false ?  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.note.title, style: TextStyle(color: Colors.white, fontFamily: "Merriweather",fontWeight: FontWeight.bold, fontSize: 20.0, decoration: TextDecoration.none), ),
                  SizedBox(height: 8.0,),
                  Text("@ ${DateFormat.MMMEd().format(DateTime.parse(widget.note.createdAt))}", style: TextStyle(color: Colors.white70, fontFamily: "Karla",fontWeight: FontWeight.bold, fontSize: 14.0, decoration: TextDecoration.none, height: 1.4), ),
                  SizedBox(height: 20.0,),
                  Text(widget.note.description, style: TextStyle(color: Colors.white, fontFamily: "Karla",fontWeight: FontWeight.bold, fontSize: 16.0, decoration: TextDecoration.none, height: 1.4), ),
                ],
            ):Form(
              key: _formKey,
                          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                          initialValue: widget.note.title,
                           keyboardType: TextInputType.multiline,
                           textCapitalization: TextCapitalization.sentences,
                           maxLines: null,
                          style: TextStyle(color: Colors.white70, fontFamily: "Merriweather",fontWeight: FontWeight.bold, fontSize: 20.0,),
                          decoration: InputDecoration(fillColor: Theme.of(context).accentColor, hintText: "Title",hintStyle: TextStyle(color: Colors.white70),),
                          onChanged: (String noteTitle){
                            setState(() {
                              title = noteTitle.trim();
                            });
                          },
                          validator: (value){
                            if(value.isEmpty){
                              return "Please enter the note title";
                            }else if(value.length > titleLength){
                              return "Please keep the note title to less than $titleLength characters long";
                            }
                            return null;
                          },
                    ),
                     if(title.trim().length > 0)...[
                      Text("${title.trim().length} / $titleLength characters", style: TextStyle(color: Colors.white70, decoration: TextDecoration.none, fontSize: 12.0,),)
                     ],
                     Container(
                              // height: MediaQuery.of(context).size.height * (2 / 3),
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                initialValue: widget.note.description,
                                keyboardType: TextInputType.multiline,
                                textCapitalization: TextCapitalization.sentences,
                                maxLines: null,
                              style: TextStyle(color: Colors.white70, fontFamily: "Karla",),
                              decoration: InputDecoration(fillColor: Theme.of(context).accentColor, hintText: "Type something...",hintStyle: TextStyle(color: Colors.white70),),
                              onChanged: (String noteDesc){
                                setState(() {
                                  description = noteDesc.trim();
                                });
                              },
                              validator: (value){
                                if(value.isEmpty){
                                  return "Please type something";
                                }
                                return null;
                              },
                      ) ,
                    ),
                    const SizedBox(height: 16.0),
                      Row(children: <Widget>[
                        Text("Note Color", style: TextStyle(color: Colors.white),),
                      OutlineButton(
                        color: Theme.of(context).accentColor,
                        onPressed: _openColorPicker,
                        child: const Text('Choose Color', style: TextStyle(color: Colors.white70),),
                      ),

                      ],),
                        RaisedButton(child: Text("Update", style: TextStyle(color: Colors.white70),),color: Theme.of(context).accentColor, onPressed: (){
                        setState(() {
                          noteColor = _shadeColor;
                        });
                          if(_formKey.currentState.validate()){
                            // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Note Updated"), backgroundColor: Theme.of(context).accentColor, duration: Duration(milliseconds: 1000),));
                            Provider.of<NotesProvider>(context, listen: false).updateNote(Note(noteId:widget.note.noteId, title: title, description: description, createdAt: widget.note.createdAt, noteColor: noteColor.toString() ));
                            // _formKey.currentState.reset();
                            _displaySnackBar(context,"Note Updated");
                            FocusScope.of(context).requestFocus(FocusNode());
                            Navigator.of(context).pop();
                          }else{
                            _displaySnackBar(context,"Please fill all the fields.");
                            // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please fill all the fields."), backgroundColor: Theme.of(context).accentColor,));
                          }
                        }, )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

   _displaySnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text), backgroundColor: Theme.of(context).accentColor);
    _scaffoldKey.currentState.showSnackBar(snackBar);  
  }
}
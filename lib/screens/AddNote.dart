import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/Note.dart';
import 'package:todoapp/providers/notes_provider.dart';
import 'package:uuid/uuid.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var uuid = Uuid();
  final _formKey = GlobalKey<FormState>();

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  String title = "";
  String description;
  Color noteColor;
  int titleLength = 200;
  Color _tempShadeColor;
  Color _shadeColor = Color(0xff00171f);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
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
    body: SafeArea(
      child:Container(
      padding: EdgeInsets.symmetric(horizontal:20.0, vertical:12.0),
      color: Theme.of(context).primaryColor,
      height: double.infinity,
      child:     SingleChildScrollView(
        child: Form(
            key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                      TextFormField(
                         keyboardType: TextInputType.multiline,
                         textCapitalization: TextCapitalization.sentences,
                         maxLines: null,
                         style: Theme.of(context).primaryTextTheme.headline6,
                        // style: TextStyle(color: Colors.white70, fontFamily: "Merriweather",fontWeight: FontWeight.bold, fontSize: 20.0,),
                        decoration: InputDecoration(fillColor: Theme.of(context).accentColor, hintText: "Title",hintStyle: Theme.of(context).primaryTextTheme.subtitle1,),
                        // decoration: InputDecoration(fillColor: Theme.of(context).accentColor, hintText: "Title",hintStyle: TextStyle(color: Colors.white70),),
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
                         Text("${title.trim().length} / $titleLength characters", style: Theme.of(context).primaryTextTheme.subtitle1)
                      ],
                    const SizedBox(height: 32.0),
                     Container(
                            // height: MediaQuery.of(context).size.height * (2 / 3),
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              textCapitalization: TextCapitalization.sentences,
                              maxLines: null,
                              style:Theme.of(context).primaryTextTheme.subtitle1,
                            // style: TextStyle(color: Colors.white70, fontFamily: "Karla",),
                            decoration: InputDecoration(fillColor: Theme.of(context).accentColor, hintText: "Type something...",hintStyle: Theme.of(context).primaryTextTheme.subtitle1,),
                            // decoration: InputDecoration(fillColor: Theme.of(context).accentColor, hintText: "Type something...",hintStyle: TextStyle(color: Colors.white70),),
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
                          ) ,),
                        
                      
                    const SizedBox(height: 24.0),
                    Row(children: <Widget>[
                      Text("Note Color", style: Theme.of(context).primaryTextTheme.subtitle1,),
                      SizedBox(width: 30.0,),
                    OutlineButton(
                      color: Theme.of(context).primaryColor,
                      // color: Theme.of(context).accentColor,
                      onPressed: _openColorPicker,
                      child:Text("Choose Color", style: Theme.of(context).primaryTextTheme.subtitle1,) ,
                      // child: const Text('Choose Color', style: Theme.of(context).primaryTextTheme.subtitle1,),
                    ),

                    ],),
                      RaisedButton(child: Text("Save", style: TextStyle(color: Colors.white)),color: Theme.of(context).buttonColor, onPressed: (){
                      setState(() {
                        noteColor = _shadeColor;
                      });
                        if(_formKey.currentState.validate()){
                          // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Note Saved"), backgroundColor: Theme.of(context).accentColor, duration: Duration(milliseconds: 1000),));
                          Provider.of<NotesProvider>(context, listen: false).addNote(Note(noteId:uuid.v4(),title: title, description: description, createdAt: DateTime.now().toString(), noteColor: noteColor.toString() ));
                          _formKey.currentState.reset();
                          FocusScope.of(context).requestFocus(FocusNode());
                        }else{
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please fill all the fields."), backgroundColor: Theme.of(context).accentColor,));
                        }
                      }, )
                      
              ],
            ),
          ),
      ),
    ) ,
    )
  );

    // return SingleChildScrollView(
    //   // height: MediaQuery.of(context).size.height,
    //   // padding: EdgeInsets.symmetric(horizontal:20.0, vertical:12.0),
    //   // color: Color(0xff010001),
    //   child:     Container(
    //     // height: MediaQuery.of(context).size.height,
    //   padding: EdgeInsets.symmetric(horizontal:20.0, vertical:12.0),
    //   color: Color(0xff010001),
    //     child: Form(
    //         key: _formKey,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //                   TextFormField(
    //                      keyboardType: TextInputType.multiline,
    //                      textCapitalization: TextCapitalization.sentences,
    //                      maxLines: null,
    //                     style: TextStyle(color: Colors.white70, fontFamily: "Merriweather",fontWeight: FontWeight.bold, fontSize: 20.0,),
    //                     decoration: InputDecoration(fillColor: Theme.of(context).accentColor, hintText: "Title",hintStyle: TextStyle(color: Colors.white70),),
    //                     onChanged: (String noteTitle){
    //                       setState(() {
    //                         title = noteTitle.trim();
    //                       });
    //                     },
    //                     validator: (value){
    //                       if(value.trim().isEmpty){
    //                         return "Please enter the note title";
    //                       }else if(value.trim().length > titleLength){
    //                         return "Please keep the note title to less than $titleLength characters long";
    //                       }
    //                       return "";
    //                     },
    //                   ),
    //                   if(title.trim().length > 0)...[
    //                      Text("${title.trim().length} / $titleLength characters", style: TextStyle(color: Colors.white70, decoration: TextDecoration.none, fontSize: 12.0,),)
    //                   ],
    //                     LimitedBox(
    //                       maxHeight:MediaQuery.of(context).size.height * (2 / 3) ,
    //                         child: Container(
    //                         // height: MediaQuery.of(context).size.height * (2 / 3),
    //                         width: MediaQuery.of(context).size.width,
    //                         child: TextFormField(
    //                           keyboardType: TextInputType.multiline,
    //                           textCapitalization: TextCapitalization.sentences,
    //                           maxLines: null,
    //                         style: TextStyle(color: Colors.white70, fontFamily: "Karla",),
    //                         decoration: InputDecoration(fillColor: Theme.of(context).accentColor, hintText: "Type something...",hintStyle: TextStyle(color: Colors.white70),),
    //                         onChanged: (String noteDesc){
    //                           setState(() {
    //                             description = noteDesc.trim();
    //                           });
    //                         },
    //                         validator: (value){
    //                           if(value.isEmpty){
    //                             return "Please type something";
    //                           }
    //                           return null;
    //                         },
    //                       ) ,),
    //                     ),
                      
    //                 const SizedBox(height: 16.0),
    //                 Row(children: <Widget>[
    //                   Text("Note Color", style: TextStyle(color: Colors.white),),
    //                 OutlineButton(
    //                   color: Theme.of(context).accentColor,
    //                   onPressed: _openColorPicker,
    //                   child: const Text('Choose Color', style: TextStyle(color: Colors.white70),),
    //                 ),

    //                 ],),
    //                   RaisedButton(child: Text("Save", style: TextStyle(color: Colors.white70),),color: Theme.of(context).accentColor, onPressed: (){
    //                   setState(() {
    //                     noteColor = _shadeColor;
    //                   });
    //                     if(_formKey.currentState.validate()){
    //                       Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saving the note..."), backgroundColor: Theme.of(context).accentColor, duration: Duration(milliseconds: 1000),));
    //                       Provider.of<NotesProvider>(context, listen: false).addNote(Note(title: title, description: description, createdAt: DateTime.now().toString(), noteColor: noteColor.toString() ));
    //                       _formKey.currentState.reset();
    //                     }else{
    //                       Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please fill all the fields."), backgroundColor: Theme.of(context).accentColor,));
    //                     }
    //                   }, )
                      
    //           ],
    //         ),
    //       ),
    //   ),
    // );
  }
}
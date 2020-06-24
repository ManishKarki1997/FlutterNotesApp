import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _formKey = GlobalKey<FormState>();

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  } 


  @override
  Widget build(BuildContext context) {

ColorSwatch _tempMainColor;
  Color _tempShadeColor;
  Color _shadeColor = Colors.blue[800];
  ColorSwatch _mainColor = Colors.blue;

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
                setState(() => _mainColor = _tempMainColor);
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
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
        onBack: () => print("Back button pressed"),
      ),
    );
  }

  

    return SingleChildScrollView(
      // height: MediaQuery.of(context).size.height,
      // padding: EdgeInsets.symmetric(horizontal:20.0, vertical:12.0),
      // color: Color(0xff010001),
      child:     Container(
        height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal:20.0, vertical:12.0),
      color: Color(0xff010001),
        child: Form(
            key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                      TextFormField(
                         keyboardType: TextInputType.multiline,
                         maxLines: null,
                        style: TextStyle(color: Colors.white70, fontFamily: "Merriweather",fontWeight: FontWeight.bold, fontSize: 20.0,backgroundColor: Theme.of(context).accentColor,),
                        decoration: InputDecoration(fillColor: Theme.of(context).accentColor, hintText: "Title",hintStyle: TextStyle(color: Colors.white70),),
                        validator: (value){
                          if(value.isEmpty){
                            return "Please enter the note title";
                          }
                          return null;
                        },
                      ),
                        LimitedBox(
                          maxHeight:MediaQuery.of(context).size.height * (2 / 3) ,
                            child: Container(
                            // height: MediaQuery.of(context).size.height * (2 / 3),
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            style: TextStyle(color: Colors.white70, fontFamily: "Karla",backgroundColor: Theme.of(context).accentColor,),
                            decoration: InputDecoration(fillColor: Theme.of(context).accentColor, hintText: "Type something...",hintStyle: TextStyle(color: Colors.white70),),
                            validator: (value){
                              if(value.isEmpty){
                                return "Please type something";
                              }
                              return null;
                            },
                          ) ,),
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
                      RaisedButton(child: Text("Save", style: TextStyle(color: Colors.white70),),color: Theme.of(context).accentColor, onPressed: (){
                      debugPrint("temp shade color is : $_shadeColor");
                        if(_formKey.currentState.validate()){
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saving the note..."), backgroundColor: Theme.of(context).accentColor,));
                        }else{
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please fill all the fields."), backgroundColor: Theme.of(context).accentColor,));
                        }
                      }, )
                      
              ],
            ),
          ),
      ),
    );
  }
}
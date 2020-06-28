import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/notes_provider.dart';
import 'package:todoapp/screens/SingleNote.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  int deleteNoteIndex;

  showDeleteAlertDialog(BuildContext context) {
    var notesProvider = Provider.of<NotesProvider>(context, listen: false);
    Widget cancelBtn = FlatButton(
      child: Text("Cancel",
          style: TextStyle(color: Theme.of(context).accentColor)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget deleteBtn = FlatButton(
      child:
          Text("Yes", style: TextStyle(color: Theme.of(context).accentColor)),
      onPressed: () {
        Navigator.of(context).pop();
        notesProvider.deleteNote(notesProvider.notes[deleteNoteIndex]);
      },
    );

    AlertDialog dialog = AlertDialog(
      title: Text("Delete Note",
          style: TextStyle(color: Theme.of(context).accentColor)),
      backgroundColor: Theme.of(context).backgroundColor,
      content: Text(
        "Are you sure you want to delete the note?",
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
      actions: <Widget>[cancelBtn, deleteBtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    var notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: notesProvider.notes.length > 0
            ? Container(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: notesProvider.notes.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onLongPress: () {
                      // delete the note
                      setState(() {
                        deleteNoteIndex = index;
                      });
                      showDeleteAlertDialog(context);
                    },
                    onDoubleTap: () {
                      // edit the note
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleNote(
                                    note: notesProvider.notes[index],
                                    editMode: true,
                                  )));
                    },
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleNote(
                                    note: notesProvider.notes[index],
                                    editMode: false,
                                  )));
                    },
                    child: Container(
                      // height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        // color: Theme.of(context).accentColor
                        color: Color(int.parse(notesProvider
                            .notes[index].noteColor
                            .substring(6, 16))),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              notesProvider.notes[index].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Raleway",
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              DateFormat.MMMEd().format(DateTime.parse(
                                  notesProvider.notes[index].createdAt)),
                              style: TextStyle(
                                  color: Colors.grey.shade400, fontSize: 13.0),
                            ),
                            // Text(formatDate(DateTime.parse(notesProvider.notes[index].createdAt),  [ mm, '/', dd, ' ', hh, ':', nn, ' ', am]), style: TextStyle(color: Colors.grey.shade400, fontSize: 13.0),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  staggeredTileBuilder: (int index) => new StaggeredTile.count(
                      2,
                      (notesProvider.notes[index].title.toString().length <= 40)
                          ? 1.2
                          : (notesProvider.notes[index].title
                                          .toString()
                                          .length >
                                      40 &&
                                  notesProvider.notes[index].title
                                          .toString()
                                          .length <=
                                      80)
                              ? 2.4
                              : 4),
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 6.0,
                ),
              )
            : Container(
                color: Theme.of(context).primaryColor,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Create a note",
                    style: TextStyle(
                        color: Colors.white70,
                        fontFamily: "Karla",
                        fontSize: 18.0),
                  ),
                )),
      ),
    );

//     return notesProvider.notes.length > 0 ? SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
//         height: MediaQuery.of(context).size.height,
//         color: Theme.of(context).primaryColor,
//         child: StaggeredGridView.countBuilder(
//   crossAxisCount: 4,
//   itemCount: notesProvider.notes.length,
//   itemBuilder: (BuildContext context, int index) => new Container(
//     height: double.infinity,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0),
//         // color: Theme.of(context).accentColor
//         color: Color(int.parse(notesProvider.notes[index].noteColor.substring(6,16))),
//         ),
//         child: GestureDetector(
//           onTap: (){
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleNote(note: notesProvider.notes[index],)));
//           },
//                   child: Container(
//             padding: EdgeInsets.symmetric(horizontal:20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(notesProvider.notes[index].title, style: TextStyle(color: Colors.white70, fontFamily: "Raleway",
//                 fontSize: 16.0, fontWeight: FontWeight.bold, height: 1.4,),),
//                 SizedBox(height:8.0),
//                 Text(DateFormat.MMMEd().format(DateTime.parse(notesProvider.notes[index].createdAt)), style: TextStyle(color: Colors.grey.shade400, fontSize: 13.0),),
//                 // Text(formatDate(DateTime.parse(notesProvider.notes[index].createdAt),  [ mm, '/', dd, ' ', hh, ':', nn, ' ', am]), style: TextStyle(color: Colors.grey.shade400, fontSize: 13.0),),
//               ],
//             ),
//           ),
//         )),
//   staggeredTileBuilder: (int index) =>
//         new StaggeredTile.count(2, (notesProvider.notes[index].title.toString().length <= 35) ? 1 :  (notesProvider.notes[index].title.toString().length > 40 && notesProvider.notes[index].title.toString().length <= 80 ) ? 3 :  4),
//   mainAxisSpacing: 6.0,
//   crossAxisSpacing: 6.0,
// ),
//       ),
//     ) : Container(
//           color: Theme.of(context).primaryColor,
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Center(
//               child: Text("Create a note", style: TextStyle(color: Colors.white70, fontFamily: "Karla", fontSize: 18.0)
//             ,
//           ),
//         ),
//       );
  }
}

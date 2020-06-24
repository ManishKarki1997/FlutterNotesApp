import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
        height: MediaQuery.of(context).size.height,
        child: StaggeredGridView.countBuilder(
  crossAxisCount: 4,
  itemCount: 8,
  itemBuilder: (BuildContext context, int index) => new Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0),
        color: Colors.green,
        ),
        child: new Center(
          child: new CircleAvatar(
            backgroundColor: Colors.white,
            child: new Text('$index'),
          ),
        )),
  staggeredTileBuilder: (int index) =>
        new StaggeredTile.count(2, index.isEven ? 2 : 1),
  mainAxisSpacing: 6.0,
  crossAxisSpacing: 6.0,
),
      ),
    );
  }
}
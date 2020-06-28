import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/notes_provider.dart';
import 'package:todoapp/screens/AddNote.dart';
import 'package:todoapp/screens/Notes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
  var notesProvider = Provider.of<NotesProvider>(context);
  notesProvider.loadPreferences();
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes", style: Theme.of(context).primaryTextTheme.headline6,),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.wb_sunny), onPressed: (){
            notesProvider.toggleTheme();
          },)
        ],
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 4,
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          Notes(),
          AddNote(),
        ],
        onPageChanged: (index){
          setState(() {
            _selectedIndex = index;
          });
          _pageController.animateToPage(index, duration: Duration(milliseconds: 100), curve: Curves.easeIn);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.note),
          title: Text("Notes"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          title: Text("Add"),
        ),
      
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).accentColor,
      unselectedItemColor: Theme.of(context).hoverColor,
      // unselectedItemColor: Colors.grey.shade500,
      backgroundColor: Theme.of(context).backgroundColor,
      // backgroundColor: Color(0xff010001),
      onTap: (int index){
        setState(() {
          _selectedIndex = index;
        });
        _pageController.jumpToPage(index);
      },
      ),
    );
  }


  // void _onNavItemTapped(int index){
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
}
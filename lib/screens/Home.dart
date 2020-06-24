import 'package:flutter/material.dart';
import 'package:todoapp/screens/AddNote.dart';
import 'package:todoapp/screens/Notes.dart';
import 'package:todoapp/screens/Settings.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes",),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){},)
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          Notes(),
          AddNote(),
          Settings()
        ],
        onPageChanged: (index){
          setState(() {
            _selectedIndex = index;
          });
          _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
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
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text("Settings"),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey.shade500,
      backgroundColor: Color(0xff010001),
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
import 'package:corona_tracker/frontend/pages/cure_page.dart';
import 'package:corona_tracker/frontend/pages/home_page.dart';
import 'package:corona_tracker/frontend/pages/map_page.dart';
import 'package:corona_tracker/frontend/pages/news_page/news_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    CurePage(),
    MapPage(),
    NewsPage()
  ];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.card_membership),
      title: Text('Messages'),
    ),
    BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Map')),
    BottomNavigationBarItem(icon: Icon(Icons.book), title: Text('News'))
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: CustomDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: items),

      body: _children[_currentIndex],
    );
  }
}

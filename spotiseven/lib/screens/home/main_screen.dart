import 'package:flutter/material.dart';
import 'package:spotiseven/screens/home/home_screen.dart';

class MainScreenWrapper extends StatefulWidget {
  @override
  _MainScreenWrapperState createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {

  // Select Screen from BottomNavigationBar
  int _currentIndex = 0;
  // Children to wrap
  List<Widget> _children = [
    HomeScreenWrapper(),
    HomeScreenWrapper(),
    HomeScreenWrapper(),
    HomeScreenWrapper(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        // TODO: Change this color
        fixedColor: Colors.cyan,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('')),
          // TODO: Change 'hearing' icon to podcast
          BottomNavigationBarItem(icon: Icon(Icons.hearing), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('')),
        ],
        onTap: (index) {
          print('bottom: $index');
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _children[_currentIndex],
    );
  }
}

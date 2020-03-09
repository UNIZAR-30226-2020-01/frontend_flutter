import 'package:flutter/material.dart';
import 'package:spotiseven/screens/home/album/album_detail.dart';

class HomeScreenWrapper extends StatefulWidget {
  @override
  _HomeScreenWrapperState createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper> {

  // To control index
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          // TODO: Change this color
          backgroundColor: Colors.cyan,
          bottom: TabBar(
            // TODO: Use <indicator> property to change indicator
            isScrollable: true,
            // TODO: change labelStyle
            labelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            tabs: <Widget>[
              Tab(child: Text('Following')),
              Tab(child: Text('Your playlists')),
              Tab(child: Text('Genres')),
              Tab(child: Text('Albums')),
              Tab(child: Text('Artists')),
            ],
            onTap: (value) {
              print('tab: $value');
              setState(() {
                _currentIndex = value;
              });
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Item Selected: $_currentIndex'),
            Row(
              children: <Widget>[
                AlbumCardWidget(),
//                AlbumDetailWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

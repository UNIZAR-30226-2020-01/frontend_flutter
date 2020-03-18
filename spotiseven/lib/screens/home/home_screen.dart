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
        // TODO: Change this color
        backgroundColor: Color(0xff73afc5),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              TabBar(
                // TODO: Use <indicator> property to change indicator
                isScrollable: true,
                indicatorColor: Colors.black,
                // TODO: change labelStyle -> By the moment changed in tab's text
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                onTap: (value) => setState(() => _currentIndex = value),
                tabs: <Widget>[
                  buildTextTab('Following'),
                  buildTextTab('Your playlists'),
                  buildTextTab('Genres'),
                  buildTextTab('Albums'),
                  buildTextTab('Artists'),
                ],
              ),
              // Contenido principal de la pantalla
              // TODO: Cambiar a ListView
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Item Selected: $_currentIndex'),
                  Row(
                    children: <Widget>[
                      AlbumCardWidget(),
                      AlbumCardWidget(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Tab buildTextTab(String text) =>
      Tab(child: Text(text, style: TextStyle(color: Colors.black)));
}

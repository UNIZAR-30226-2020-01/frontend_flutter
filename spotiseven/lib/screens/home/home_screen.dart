// TODO: Remove this import
import 'package:flutter/material.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/screens/home/albums.dart';
import 'package:spotiseven/screens/artist/artist_screen.dart';
import 'package:spotiseven/screens/home/following.dart';
import 'package:spotiseven/screens/home/genres.dart';
import 'package:spotiseven/screens/home/your_playlists.dart';

class HomeScreenWrapper extends StatefulWidget {
  @override
  _HomeScreenWrapperState createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper>
    with SingleTickerProviderStateMixin {
  // Control de la reproduccion
  PlayingSingleton _playingSingleton = PlayingSingleton();

  // To control index
  int _currentIndex = 0;

  // To control TabBar
  TabController _tabController;

  // Tabs
  List<Widget> _myTabs = [
    FollowingScreen(),
    PlaylistsScreen(),
    GenresScreen(),
    AlbumScreen(),
    ArtistScreen(),
  ];

  @override
  void initState() {
    _tabController =
        TabController(vsync: this, length: _myTabs.length, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Change this color
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.black,
              child: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  // TODO: Use <indicator> property to change indicator
                  indicatorPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  indicatorColor: Colors.yellow[800],
                  indicatorWeight: 7,
                  indicatorSize: TabBarIndicatorSize.tab,
                  // TODO: change labelStyle -> By the moment changed in tab's text
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: <Widget>[
                    buildTextTab('Following'),
                    buildTextTab('Your playlists'),
                    buildTextTab('Genres'),
                    buildTextTab('Albums'),
                    buildTextTab('Artists'),
                  ],
                ),
              ),
            ),
            // Contenido principal de la pantalla
            // TODO: Cambiar a ListView (Hacer en otro widget)
            Container(
              margin: EdgeInsets.only(top: 60),
              child: TabBarView(
                controller: _tabController,
                children: _myTabs,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Tab buildTextTab(String text) =>
      Tab(child: Text(text, style: TextStyle(color: Colors.white)));
}

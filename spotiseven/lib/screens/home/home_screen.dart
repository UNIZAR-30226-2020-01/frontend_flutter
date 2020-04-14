import 'package:flutter/material.dart';
import 'package:spotiseven/screens/home/albums.dart';
import 'package:spotiseven/screens/home/artist_home.dart';
import 'package:spotiseven/screens/home/followings.dart';
import 'package:spotiseven/screens/home/genres.dart';
import 'package:spotiseven/screens/home/your_playlists.dart';

class HomeScreenWrapper extends StatefulWidget {
  @override
  _HomeScreenWrapperState createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper>
    with SingleTickerProviderStateMixin {

  // To control TabBar
  TabController _tabController;

  // Tabs
  List<Widget> _myTabs = [
    PlaylistsScreen(),
    AlbumScreen(),
    ArtistScreen(),
    MyPlaylists(),
    GenresScreen(),
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
                  /*indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 10, color: Colors.yellow,),
                    insets: EdgeInsets.all(5),
                  ),*/
                  controller: _tabController,
                  isScrollable: true,
                  // TODO: Use <indicator> property to change indicator
                  indicatorPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 5),
//                  indicatorColor: Colors.yellow[800],
                  indicatorColor: Colors.white,
                  indicatorWeight: 7,
                  indicatorSize: TabBarIndicatorSize.tab,
                  // TODO: change labelStyle -> By the moment changed in tab's text
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: <Widget>[
                    buildTextTab('Following'),
                    buildTextTab('Albums'),
                    buildTextTab('Artists'),
                    buildTextTab('Your playlists'),
                    buildTextTab('Genres'),
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

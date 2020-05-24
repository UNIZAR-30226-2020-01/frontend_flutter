import 'package:flutter/material.dart';
import 'package:spotiseven/screens/home/albums.dart';
import 'package:spotiseven/screens/home/artist_home.dart';
import 'package:spotiseven/screens/home/following.dart';
import 'package:spotiseven/screens/home/most_kwon.dart';
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
    FollowingScreen(),
    MostPlayed(),
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: TabBar(
                      /*indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 10, color: Colors.yellow,),
                        insets: EdgeInsets.all(5),
                      ),*/
                      controller: _tabController,
                      isScrollable: true,
                      indicatorPadding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
//                  indicatorColor: Colors.yellow[800],
                      indicatorColor: Colors.white,
                      indicatorWeight: 7,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: <Widget>[
                        buildTextTab('Your playlists'),
                        buildTextTab('Albums'),
                        buildTextTab('Artists'),
                        buildTextTab('Following'),
                        buildTextTab('Most Played')
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Contenido principal de la pantalla
            Container(
              margin: EdgeInsets.only(top: 60, bottom: 20),
              child: Center(
                child: TabBarView(
                  controller: _tabController,
                  children: _myTabs,
                ),
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

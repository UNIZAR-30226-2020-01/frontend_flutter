// TODO: Remove this import
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/screens/podcast/discoverpodcast.dart';
import 'package:spotiseven/screens/podcast/subscriptionpodcast.dart';

import 'newpodcast.dart';

class PodcastScreenWrapper extends StatefulWidget {
  @override
  _PodcastScreenWrapper createState() => _PodcastScreenWrapper();
}

class _PodcastScreenWrapper extends State<PodcastScreenWrapper>
    with SingleTickerProviderStateMixin {

  // To control index
  int _currentIndex = 0;

  // To control TabBar
  TabController _tabController;

  // Tabs
  List<Widget> _myTabs = [
//    NewPodcast(),
    SubscriptionPodcast(),
    DiscoverPodcast(),
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
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(80, 0, 30, 0),
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: PreferredSize(
                  preferredSize: Size.fromHeight(5000),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
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
//                        buildTextTab('NEW PODCAST'),
                        buildTextTab('SUBSCRIPTION'),
                        buildTextTab('DISCOVER'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Contenido principal de la pantalla
            // TODO: Cambiar a ListView (Hacer en otro widget)F
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

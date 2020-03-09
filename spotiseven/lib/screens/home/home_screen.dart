import 'package:flutter/material.dart';

class HomeScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(child: Text('Following')),
              Tab(child: Text('Your playlists')),
              Tab(child: Text('Genres')),
              Tab(child: Text('Albums')),
              Tab(child: Text('Artists')),
            ],
          ),
        ),
        body: Center(
          child: Text('Hello world'),
        ),
      ),
    );
  }
}

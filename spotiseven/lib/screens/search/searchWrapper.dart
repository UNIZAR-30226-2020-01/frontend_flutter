import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/album.dart';
import 'package:spotiseven/audio/utils/artist.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/screens/podcast/discoverpodcast.dart';
import 'package:spotiseven/screens/podcast/subscriptionpodcast.dart';
import 'package:spotiseven/screens/search/searchResult/albumsFound.dart';
import 'package:spotiseven/screens/search/searchResult/artistFound.dart';
import 'package:spotiseven/screens/search/searchResult/playlistFound.dart';
import 'package:spotiseven/screens/search/searchResult/podcastChapters.dart';
import 'package:spotiseven/screens/search/searchResult/podcastFound.dart';
import 'package:spotiseven/screens/search/searchResult/songFound.dart';
import 'package:spotiseven/screens/search/searchResult/usersFound.dart';
import 'package:spotiseven/user/user.dart';

class SearchWrapper extends StatefulWidget {
  List<Playlist> pls;
  List<Song> songs;
  List<Artist> artists;
  List<Album> albums;
  List<Podcast> pods;
  List<PodcastChapter> podchaps;
  List<User> users;

  SearchWrapper({
    @required this.pls,
    @required this.songs,
    @required this.artists,
    @required this.albums,
    @required this.pods,
    @required this.podchaps,
    @required this.users
});
  @override
  _SearchWrapper createState() => _SearchWrapper();
}

class _SearchWrapper extends State<SearchWrapper>
    with SingleTickerProviderStateMixin {

  // To control index
  int _currentIndex = 0;

  // To control TabBar
  TabController _tabController;

  // Tabs
  List<Widget> _myTabs;

  @override
  void initState() {
    _myTabs = [
      PlaylistFound(foundpl: widget.pls,),
      SongFound(foundsong: widget.songs,),
      AlbumsFound(foundAlbum: widget.albums,),
      ArtistFound(foundArtist: widget.artists,),
      PodcastFound(),
      ChaptersFound(),
      UserFound(founduser: widget.users,)
    ];
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
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: PreferredSize(
                  preferredSize: Size.fromHeight(5000),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                        buildTextTab('PLAYLISTS'),
                        buildTextTab('SONGS'),
                        buildTextTab('ALBUMS'),
                        buildTextTab('ARTISTS'),
                        buildTextTab('PODCASTS'),
                        buildTextTab('PODCAST CHAPTERS'),
                        buildTextTab('USERS')
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/screens/search/searchResult/albumsFound.dart';
import 'package:spotiseven/screens/search/searchResult/artistFound.dart';
import 'package:spotiseven/screens/search/searchResult/playlistFound.dart';
import 'package:spotiseven/screens/search/searchResult/podcastChaptersFound.dart';
import 'package:spotiseven/screens/search/searchResult/podcastFound.dart';
import 'package:spotiseven/screens/search/searchResult/songFound.dart';
import 'package:spotiseven/screens/search/searchResult/usersFound.dart';
import 'package:spotiseven/user/user.dart';

class SearchWrapper extends StatefulWidget {
  List<Playlist> pls;
  String word;

  SearchWrapper({
    @required this.pls,
    @required this.word,
});
  @override
  _SearchWrapper createState() => _SearchWrapper();
}

class _SearchWrapper extends State<SearchWrapper>
    with SingleTickerProviderStateMixin {

  // To show reproductor bar
  bool _showReprBar = false;

  // PlayingSingleton
  PlayingSingleton _player;

  // Suscripcion al evento de estado de la reproduccion (impedira memory leaks)
  StreamSubscription _subscriptionState;

  // Suscripcion al evento de cambio de cancion en reproduccion
  StreamSubscription _subscriptionSong;

  String get word => widget.word;
  // To control index
  int _currentIndex = 0;

  // To control TabBar
  TabController _tabController;

  // Tabs
  List<Widget> _myTabs;

  @override
  void initState() {
    _myTabs = [
      PlaylistFound(foundpl: widget.pls,word: word,),
      SongFound(word: word,),
      AlbumsFound(word: word,),
      ArtistFound(word: word,),
      PodcastFound(word: word,),
      ChaptersFound(word: word,),
      UserFound(word: word,)
    ];
    _tabController =
        TabController(vsync: this, length: _myTabs.length, initialIndex: 0);
    _player = PlayingSingleton();
    // Ante el cambio del estado del reproductor central
    _subscriptionState = subscribeStateEvents();
    _subscriptionSong =
        _player.getStreamedSong().listen((s) => setState(() {}));
    super.initState();
  }

  StreamSubscription subscribeStateEvents() =>
      _player.getStreamedPlayedState().listen((playerState) {
        // TODO: Añadir evento Completed para recargar la vista
        if ([PlayerState.PLAYING, PlayerState.PAUSED].contains(playerState)) {
          // El reproductor se ha pausado o ha empezado a reproducir. Actualizamos el estado
          setState(() {});
        }
      });


  @override
  void dispose() {
    _tabController.dispose();
    _subscriptionState.cancel();
    _subscriptionSong.cancel();
    super.dispose();
  }

  _appBar(String s){
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height*0.07),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 3
            )
          )
        ),
        child: AppBar(
          backgroundColor: Colors.black,
          brightness: Brightness.dark,
          automaticallyImplyLeading: false,
          title: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                  iconSize: 30,
                ),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    'SEARCHING: ',
                    style: GoogleFonts.roboto(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    s,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }

  bool _showFloatingButton() {
/*    if(_firstTime){
      return true;
    }*/
    return !_showReprBar && _player.song != null;
  }

  bool _showReprobar() {
    return _showReprBar && _player.song != null;
  }

  Widget buildReproBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
      height: 80,
      decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
            bottom: BorderSide(
              color: Colors.yellow,
              width: 1.0,
            ),
          )
      ),
      child: FlatButton(
        onPressed: () async {
          print('Cambio a pantalla de reproduccion');
          // Para cancelar en caso de que cambie el audio
          if (_subscriptionState != null) {
            print('La suscripcion NO es null');
            _subscriptionState.cancel();
          }
          // TODO: mirar si quitar este await está bien
          await Navigator.pushNamed(context, '/playing');
          _subscriptionState.cancel();
          _subscriptionState = subscribeStateEvents();
          // TODO: Recargar el estado a la vuelta para cambios.
          setState(() {
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundImage: NetworkImage(_player.song.photoUrl),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: Text(
                      '${_player.song.title}',
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
//              SizedBox(height: 10),
                  Text(
                    '${_player.song.album.artista.name}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  print('play');
                  setState(() {
                    _player.changeReproductionState();
                  });
                },
                icon: Icon(
                  _player.playing ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                iconSize: 30,
              ),
            ),
            IconButton(
              onPressed: () => setState(() => _showReprBar = false),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(widget.word),
      backgroundColor: Colors.white,
      floatingActionButton: _showFloatingButton()
          ? FloatingActionButton(
        onPressed: () async {
          /*if(_firstTime){
            // TODO: Si se escucha doble es cosa de que esto hay que gestionarlo con un stream
            print('First Time push');
            initSongFromRemote();
            setState(() {_firstTime = false;});
          }*/
          print('pressed fab');
          // Hay una canción en reproduccion. Actualizamos el estado.
          setState(() {
            _showReprBar = true;
          });
//                Navigator.pushNamed(context, '/playing');
        },
        // TODO: Change this color
//              backgroundColor: Colors.black,
        // TODO: Change this icon
        child: Transform.scale(
          scale: 2.2,
          child: IconButton(
            icon: Image.asset("assets/images/logo.png"),
//                color: Colors.transparent,
          ),
        ),
      )
          : null,
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
            _showReprobar()
                ? Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: buildReproBar(),
            )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Tab buildTextTab(String text) =>
      Tab(child: Text(text, style: TextStyle(color: Colors.white)));
}

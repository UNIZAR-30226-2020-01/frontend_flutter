import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/screens/home/home_screen.dart';
import 'package:spotiseven/screens/podcast/podcastscreen.dart';
import 'package:spotiseven/screens/search/searchBar.dart';
import 'package:spotiseven/screens/user/user_screen.dart';
import 'package:spotiseven/user/userDAO.dart';

class MainScreenWrapper extends StatefulWidget {
  @override
  _MainScreenWrapperState createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {

  // Variable para hacer la trampa de la reproducción
  bool _firstTime;

  // Select Screen from BottomNavigationBar
  int _currentIndex = 0;

  // Children to wrap
  List<Widget> _children = [
    HomeScreenWrapper(),
    PodcastScreenWrapper(),
    SearchBarScreen(),
    UserScreen(),
  ];

  // To show reproductor bar
  bool _showReprBar = false;

  // PlayingSingleton
  PlayingSingleton _player;

  // Suscripcion al evento de estado de la reproduccion (impedira memory leaks)
  StreamSubscription _subscriptionState;

  // Suscripcion al evento de cambio de cancion en reproduccion
  StreamSubscription _subscriptionSong;

  @override
  void initState() {
    _player = PlayingSingleton();
    // Ante el cambio del estado del reproductor central
    _subscriptionState = subscribeStateEvents();
    _subscriptionSong =
        _player.getStreamedSong().listen((s) => setState(() {}));
    // Buscamos en el remoto lo que se estuviera reproduciendo
    _firstTime = false;
    UserDAO.retrieveSongWithTimestamp().then((Map<String, Object> map) {
      setState(() {
        // TODO: Comprobar esta asignacion
        _firstTime = map != null;
      });
    });
    super.initState();
  }

  Future<void> initSongFromRemote() async {
    Map<String, Object> map = await UserDAO.retrieveSongWithTimestamp();
    print('Mapa: ${map.toString()}');
    if (map != null) {
      PlayingSingleton playingSingleton = PlayingSingleton();
      Song song = map['playing'] as Song;
      await playingSingleton
          .setPlayListWithoutPlaying(Playlist(
              photoUrl: song.photoUrl,
              title: song.album.titulo,
              playlist: [song],
              num_songs: 1))
          .whenComplete(() => playingSingleton.pause());
      _subscriptionState.cancel();
      await playingSingleton.play(song);
      _subscriptionState = subscribeStateEvents();
      playingSingleton.seekPosition((map['timestamp'] as Duration).inSeconds);
      setState(() {});
    }
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
    _subscriptionState.cancel();
    _subscriptionSong.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        // TODO: Change this color
        fixedColor: Color.fromRGBO(255, 242, 0, 1),
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('')),
          // TODO: Change 'hearing' icon to podcast
          BottomNavigationBarItem(icon: Icon(Icons.cast), title: Text('')),
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
      floatingActionButton: _showFloatingButton()
          ? FloatingActionButton(
              onPressed: () async {
                if(_firstTime){
                  // TODO: Si se escucha doble es cosa de que esto hay que gestionarlo con un stream
                  print('First Time push');
                  initSongFromRemote();
                  setState(() {_firstTime = false;});
                }
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
      body: Stack(
        children: <Widget>[
          _children[_currentIndex],
          _showReprobar()
              ? Positioned(
                  bottom: 0,
                  width: MediaQuery.of(context).size.width,
                  child: buildReproBar(),
                )
              : SizedBox(),
        ],
      ),
    );
  }


  bool _showFloatingButton() {
    if(_firstTime){
      return true;
    }
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
}

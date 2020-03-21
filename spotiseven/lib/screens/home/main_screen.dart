import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/screens/home/home_screen.dart';

class MainScreenWrapper extends StatefulWidget {
  @override
  _MainScreenWrapperState createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  // Select Screen from BottomNavigationBar
  int _currentIndex = 0;
  // Children to wrap
  List<Widget> _children = [
    HomeScreenWrapper(),
    HomeScreenWrapper(),
    HomeScreenWrapper(),
    HomeScreenWrapper(),
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
    _subscriptionSong = _player.getStreamedSong().listen((s) => setState(() {}));
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
        fixedColor: Colors.cyan,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('')),
          // TODO: Change 'hearing' icon to podcast
          BottomNavigationBarItem(icon: Icon(Icons.hearing), title: Text('')),
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
      floatingActionButton: !_showReprBar
          ? FloatingActionButton(
              onPressed: () {
                print('pressed fab');
                if (_player.song != null) {
                  // Hay una canción en reproduccion. Actualizamos el estado.
                  setState(() {
                    _showReprBar = true;
                  });
                } else {
                  // No hay nada en reproduccion -> No hacemos nada
                }
              },
              // TODO: Change this color
              backgroundColor: Colors.black,
              // TODO: Change this icon
              child: Icon(Icons.airplanemode_active),
            )
          : null,
      body: Stack(
        children: <Widget>[
          _children[_currentIndex],
          _showReprBar
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

  Widget buildReproBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
      height: 80,
      color: Colors.black,
      child: FlatButton(
        onPressed: () async {
          print('Cambio a pantalla de reproduccion');
          // Para cancelar en caso de que cambie el audio
          if (_subscriptionState != null) {
            print('La suscripcion NO es null');
            _subscriptionState.cancel();
          }
          await Navigator.pushNamed(context, '/playing');
          _subscriptionState.cancel();
          _subscriptionState = subscribeStateEvents();
          // TODO: Recargar el estado a la vuelta para cambios.
          setState(() {});
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(_player.song.photoUrl),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${_player.song.title}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
//              SizedBox(height: 10),
                Text(
                  '${_player.song.album.artista}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            IconButton(
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
              iconSize: 40,
            ),
            IconButton(
              onPressed: () => setState(() => _showReprBar = false),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              iconSize: 40,
            ),
          ],
        ),
      ),
    );
  }
}

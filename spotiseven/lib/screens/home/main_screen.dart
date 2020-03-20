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

  // Evento de suscripcion al estado de la reproduccion (impedira memory leaks)
  StreamSubscription _subscription;

  @override
  void initState() {
    _player = PlayingSingleton();
    // Ante el cambio del estado del reproductor central
    // FIXME: Arreglar esto con el dispose de cambio de cancion
//    _subscription = _player.getStreamedPlayedState().listen((playerState) {
//      // TODO: Añadir evento Completed para recargar la vista
//      if([PlayerState.PLAYING, PlayerState.PAUSED].contains(playerState)){
//        // El reproductor se ha pausado o ha empezado a reproducir. Actualizamos el estado
//        setState(() {});
//      }
//    });
    super.initState();
  }

  @override
  void dispose() {
//    _subscription.cancel();
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
                setState(() {
                  _showReprBar = true;
                });
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
        onPressed: () {
          print('Cambio a pantalla de reproduccion');
          Navigator.pushNamed(context, '/playing');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              // TODO: Change this dinamically
              backgroundImage: NetworkImage(
                  'https://yt3.ggpht.com/a/AATXAJzgtF2V2m4KsP1ZHU12UcqzoDBEL4GH4e_CmQ=s288-c-k-c0xffffffff-no-rj-mo'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // TODO: Change this dinamically
                Text(
                  'Song name',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
//              SizedBox(height: 10),
                Text(
                  'Artist Name',
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

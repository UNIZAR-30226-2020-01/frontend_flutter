

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/user/userDAO.dart';

class UsingPlay extends StatefulWidget {
  @override
  _UsingPlayState createState() => _UsingPlayState();
}

class _UsingPlayState extends State<UsingPlay> {
  // Variable para hacer la trampa de la reproducción
  bool _firstTime;
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
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  @override
  void dispose() {
    _subscriptionState.cancel();
    _subscriptionSong.cancel();
    super.dispose();
  }

  _floatButton(){
    return FloatingActionButton(
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
    );
  }
}

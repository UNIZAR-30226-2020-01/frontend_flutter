import 'dart:async';
import 'package:flutter/material.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/audio/utils/song.dart';

class LyricsScreen extends StatefulWidget {
  @override
  _LyricsScreenState createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {
  // Cancion en reproduccion actual
  PlayingSingleton _playingSingleton = PlayingSingleton();

  // Suscripcion
  StreamSubscription _subscription;

  @override
  void initState() {
    _playingSingleton.song.fetchRemote().whenComplete(() => setState(() {}));
    _subscription =
        _playingSingleton.getStreamedSong().listen((Song s) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = CircularProgressIndicator();
    if(_playingSingleton.song.lyrics != null && _playingSingleton.song.lyrics == " "){
      // No hay lyrics
      body = Text('La canción seleccionada no dispone de lyrics.');
    }else if(_playingSingleton.song.lyrics != null && _playingSingleton.song.lyrics.trim().length != 0){
      // Hay lyrics
      body = Text('${_playingSingleton.song.lyrics}');
    }
    // Mostramos la pantalla de las lyrics
    return Scaffold(
      appBar: AppBar(
        title: Text('Lyrics of ${_playingSingleton.song.title}'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ListView(
          children: <Widget>[
            Center(
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}

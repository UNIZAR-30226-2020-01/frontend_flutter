import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// To play audio from URL
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/audio/utils/song.dart';

class PlayingScreen extends StatefulWidget {
  @override
  _PlayingScreenState createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {

  // Objeto singleton para controlar la reproduccion de audio de manera uniforme.
  PlayingSingleton _player;
  // TODO: Comprobar si se puede desacoplar este tiempo. Creo que no.
  static int _time;

  // FIXME: Arreglar esto con el dispose de cambio de cancion
  // Suscripcion al evento de cambio de tiempo (arregla el memory leak)
  StreamSubscription _subscriptionTime;

  @override
  void initState() {
    // Obtenemos una instancia de singleton
    _player = PlayingSingleton();
    // Obtenemos el tiempo de reproduccion actual
    initVariables();
    super.initState();
  }

  void initVariables() {
    // Obtenemos el tiempo de reproduccion actual
    _time = _player.time;
    // Establecemos una funcion ante el cambio del tiempo de reproduccion
//    _subscriptionTime = _player.getStreamedTime().listen((Duration d) => setState(() {
//      _time = d.inSeconds;
//    }));
  }

  @override
  void dispose() {
    cancelVariables();
    super.dispose();
  }

  void cancelVariables() {
//    _subscriptionTime.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final double border_radius = 45;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // TODO: Change this dinamically
                    image: NetworkImage(
                        'https://image.shutterstock.com/image-photo/serious-computer-hacker-dark-clothing-600w-1557297230.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    // TODO: Change this dinamically
                    'MOTIVATION',
                    style: TextStyle(
                      // TODO: Poner la fuentes
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 80,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(border_radius),
                      topRight: Radius.circular(border_radius)),
                  color: Color(0xff9ad1e5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        buildIconButton(Icons.share, () => print('share')),
                      ],
                    ),
                    CircleAvatar(
                      // TODO: Change this dinamically
                      backgroundImage: NetworkImage(
                          'https://yt3.ggpht.com/a/AATXAJzgtF2V2m4KsP1ZHU12UcqzoDBEL4GH4e_CmQ=s288-c-k-c0xffffffff-no-rj-mo'),
                      radius: 90,
                    ),
                    Text(
                      // TODO: Change this dinamically
                      'The Song Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      // TODO: Change this dinamically
                      'Artist Name',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    // Controles de musica
                    buildAudioControlls(),
                    // ProgressBar -> En segundos
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FutureBuilder(
                          future: _player.duration,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Slider(
                                // TODO: Change this color and style if needed
                                activeColor: Colors.black,
                                inactiveColor: Color(0xff73afc5),
                                min: 0,
                                max: (snapshot.data as int).toDouble(),
                                value: _time.toDouble(),
                                // TODO: igual esto se puede hacer de otra forma
                                onChanged: (value) {
                                  print('${value.toInt().toString()}');
                                  _player.seekPosition(value.toInt());
                                  setState(() {
                                    _time = value.toInt();
                                  });
                                },
                              );
                            } else {
                              return Slider(
                                min: 0,
                                max: 0,
                                value: 0,
                              );
                            }
                          },
                        ),
                        // Tiempo en segundos
                        Text(
                          '${_player.toShortString()}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    // Controles de playlist
                    buildPlaylistControlls(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconButton buildIconButton(IconData icon, Function f) {
    return IconButton(
      onPressed: f,
      icon: Icon(
        icon,
        color: Colors.black,
      ),
      iconSize: 40,
    );
  }

  ButtonBar buildPlaylistControlls() {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        buildIconButton(Icons.subtitles, () => print('subtitles')),
        buildIconButton(Icons.playlist_add, () => print('playlist_add')),
      ],
    );
  }

  ButtonBar buildAudioControlls() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        buildIconButton(Icons.repeat, () => print('Repeat')),
        buildIconButton(Icons.skip_previous, () => print('skip_previous')),
        // TODO: Change this icon
        buildIconButton(_player.playing ? Icons.pause : Icons.play_arrow, () {
          print('play_arrow');
          setState(() {
            _player.changeReproductionState();
          });
        }),
        buildIconButton(Icons.skip_next, () async {
          print('skip_next');
          await _player.next();
          cancelVariables();
          initVariables();
          setState(() {
            // La nueva cancion empieza en el segundo 0
            _time = 0;
          });
        }),
        buildIconButton(Icons.volume_up, () => print('volume_up')),
      ],
    );
  }
}

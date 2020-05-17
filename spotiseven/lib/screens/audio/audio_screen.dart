import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/screens/audio/actual_lyrics.dart';
import 'package:spotiseven/screens/audio/actual_playlist.dart';

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
  // Suscropipcion al evento de cambio de cancion
  StreamSubscription _subscriptionFinal;

  @override
  void initState() {
    // Obtenemos una instancia de singleton
    _player = PlayingSingleton();
    // Obtenemos el tiempo de reproduccion actual
    initVariables();
    // Suscripcion al evento de cambio de cancion
    _subscriptionFinal = _player.getStreamedSong().listen((Song s) {
      cancelVariables();
      setState(() {});
      initVariables();
    });
    super.initState();
  }

  void initVariables() {
    // Obtenemos el tiempo de reproduccion actual
    _time = _player.time;
    // Establecemos una funcion ante el cambio del tiempo de reproduccion
    _subscriptionTime =
        _player.getStreamedTime().listen((Duration d) => setState(() {
              _time = d.inSeconds;
            }));
  }

  @override
  void dispose() {
    cancelVariables();
    _subscriptionFinal.cancel();
    super.dispose();
  }

  void cancelVariables() {
    _subscriptionTime.cancel();
//    _subscriptionFinal.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final double border_radius = 45;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 5,
                    30,
                    MediaQuery.of(context).size.width / 5,
                    0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // TODO: Change this dinamically (playlist photo)
                    image: NetworkImage(
//                        'https://image.shutterstock.com/image-photo/serious-computer-hacker-dark-clothing-600w-1557297230.jpg'
                        '${_player.song.photoUrl}'),
                    fit: BoxFit.cover,
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
                  color: Colors.white,
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
                      backgroundImage: NetworkImage(_player.song.photoUrl),
                      radius: 90,
                    ),
                    Text(
                      '${_player.song.title}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      '${_player.song.album.artista.name}',
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
                        StreamBuilder(
                          stream: _player.getStreamedDuration(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // -30 segundos
                                  (snapshot.data as Duration).inSeconds > 10 * 60 ?  buildIconButton(Icons.replay_30, () {
                                    _player.seekPosition(_time - 30 <= 0 ? 0 : _time - 30);
                                  }) : SizedBox(),
                                  Slider(
                                    activeColor: Colors.black,
                                    inactiveColor: Colors.black12,
                                    min: 0,
                                    max: (snapshot.data as Duration)
                                        .inSeconds
                                        .toDouble(),
                                    value: _time.toDouble(),
                                    onChanged: (value) => seekPlayerTime(value),
                                  ),
                                  // +30 segundos
                                  (snapshot.data as Duration).inSeconds > 10 * 60 ?  buildIconButton(Icons.forward_30, () {
                                    _player.seekPosition(_time + 30 <= 0 ? 0 : _time + 30);
                                  }) : SizedBox(),
                                ],
                              );
                            } else {
                              return FutureBuilder(
                                future: _player.duration,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        // -30 segundos
                                        (snapshot.data as int) > 10 * 60 ?  buildIconButton(Icons.replay_30, () {
                                          _player.seekPosition(_time - 30 <= 0 ? 0 : _time - 30);
                                        }) : SizedBox(),
                                        Slider(
                                          activeColor: Colors.black,
                                          inactiveColor: Color(0xff73afc5),
                                          min: 0,
                                          max: (snapshot.data as int).toDouble(),
                                          value: _time.toDouble(),
                                          onChanged: (value) =>
                                              seekPlayerTime(value),
                                        ),
                                        // +30 segundos
                                        (snapshot.data as int) > 10 * 60 ?  buildIconButton(Icons.forward_30, () {
                                          _player.seekPosition(_time + 30 <= 0 ? 0 : _time + 30);
                                        }) : SizedBox(),
                                      ],
                                    );
                                  } else {
                                    return Slider(
                                      onChanged: (value) => null,
                                      min: 0,
                                      max: 0,
                                      value: 0,
                                    );
                                  }
                                },
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

  void seekPlayerTime(double value) {
    print('${value.toInt().toString()}');
    _player.seekPosition(value.toInt());
    setState(() {
      _time = value.toInt();
    });
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
        buildIconButton(Icons.subtitles, () {
          print('subtitles');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LyricsScreen()));
        }),
        buildIconButton(Icons.playlist_add, () {
          print('playlist_add');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ActualPlaylistScreen(
                        playlist: _player.playlist,
                      )));
        }),
      ],
    );
  }

  ButtonBar buildAudioControlls() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        buildIconButton(_player.repeatActual ? Icons.repeat_one : Icons.repeat,
            () {
          setState(() {
            _player.repeatActual = !_player.repeatActual;
          });
          print('Repeat');
        }),
        buildIconButton(Icons.skip_previous, () async {
          print('skip_previous');
          // Si han pasado menos de 2 segundos desde el inicio de una cancion, pasamos a la anterior
          final tiempo_cambio = 2;
          if (_time <= tiempo_cambio) {
            cancelVariables();
            await _player.previous();
            initVariables();
            setState(() {
              // La nueva cancion empieza en el segundo 0
              _time = 0;
            });
          } else {
            // Si han pasado más, retrocedemos al inicio de la misma.
            _player.seekPosition(0);
          }
        }),
        // TODO: Change this icon
        buildIconButton(_player.playing ? Icons.pause : Icons.play_arrow, () {
          print('play_arrow');
          setState(() {
            _player.changeReproductionState();
          });
        }),
        buildIconButton(Icons.skip_next, () async {
          print('skip_next');
          cancelVariables();
          await _player.next();
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

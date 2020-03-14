import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// To play audio from URL
import 'package:flutter_exoplayer/audioplayer.dart';

class PlayingScreen extends StatefulWidget {
  @override
  _PlayingScreenState createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  AudioPlayer _audioPlayer = AudioPlayer();
  // TODO: Para hacer pruebas. En version final pasar como parámetro
  final String _url =
      'https://files.freemusicarchive.org/storage-freemusicarchive-org/music/no_curator/Yung_Kartz/August_2019/Yung_Kartz_-_04_-_One_Way.mp3';
  // Para controlar el tiempo de la reproducción
  int _time;
  // Para controlar el estado de la reproduccion
  bool _playing = true;

  @override
  void initState() {
    // Reproducimos la URL
    _audioPlayer.play(_url);
    // Para la actualización de la barra temporal y los segundos
    _audioPlayer.onAudioPositionChanged
        .listen((Duration d) => setState(() => _time = d.inSeconds));
    // Tiempo inicial
    _time = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double border_radius = 45;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          // TODO: Poner esto en el cuerpo del Scaffold para aumentar el tamaño y poner una imagen de fondo.
          // TODO: Change this dinamically
          'MOTIVATION',
          style: TextStyle(
            // TODO: Poner la fuentes
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
//        color: Colors.green[500],
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(border_radius),
              topRight: Radius.circular(border_radius)),
          border: Border.all(color: Colors.green),
          color: Colors.green[500],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: () => print('share'),
                  icon: Icon(Icons.share),
                  iconSize: 40,
                ),
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
                  future: _audioPlayer.getDuration(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Slider(
                        // TODO: Change this colors and style
                        activeColor: Colors.black,
                        inactiveColor: Colors.green[800],
                        min: 0,
                        max: (snapshot.data as Duration).inSeconds.toDouble(),
                        value: _time.toDouble(),
                        // TODO: igual esto se puede hacer de otra forma
                        onChanged: (value) {
                          print('${value.toInt().toString()}');
                          _audioPlayer
                              .seekPosition(Duration(seconds: value.toInt()));
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
                  '${Duration(seconds: _time).toString().substring(2, 7)}',
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
    );
  }

  ButtonBar buildPlaylistControlls() {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          onPressed: () => print('subtitles'),
          icon: Icon(Icons.subtitles),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () => print('playlist_add'),
          icon: Icon(Icons.playlist_add),
          iconSize: 40,
        ),
      ],
    );
  }

  ButtonBar buildAudioControlls() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () => print('Repeat'),
          icon: Icon(Icons.repeat_one),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () => print('skip_previous'),
          icon: Icon(Icons.skip_previous),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {
            print('play_arrow');
            if (_playing) {
              _audioPlayer.pause();
            } else {
              _audioPlayer.resume();
            }
            setState(() {
              _playing = !_playing;
            });
          },
          // TODO: Change this icon
          icon: Icon(_playing ? Icons.pause : Icons.play_arrow),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () => print('skip_next'),
          icon: Icon(Icons.skip_next),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () => print('volume_up'),
          icon: Icon(Icons.volume_up),
          iconSize: 40,
        ),
      ],
    );
  }
}

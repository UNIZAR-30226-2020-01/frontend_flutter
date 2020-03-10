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
  final String _url = 'https://files.freemusicarchive.org/storage-freemusicarchive-org/music/no_curator/Yung_Kartz/August_2019/Yung_Kartz_-_04_-_One_Way.mp3';
  // Para controlar el tiempo de la reproducción
  int _time;
  // Para controlar el estado de la reproduccion
  bool _playing = true;

  @override
  void initState() {
    // Reproducimos la URL
    _audioPlayer.play(_url);
    // Para la actualización de la barra temporal y los segundos
    _audioPlayer.onAudioPositionChanged.listen((Duration d) => setState(() => _time = d.inSeconds) );
    // Tiempo inicial
    _time = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'SONG TITLE',
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
      body: Card(
        // TODO: Poner aqui el color
        color: Colors.green[500],
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://yt3.ggpht.com/a/AATXAJzgtF2V2m4KsP1ZHU12UcqzoDBEL4GH4e_CmQ=s288-c-k-c0xffffffff-no-rj-mo'),
              radius: 70,
            ),
            Text(
              'The Song Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Artist Name',
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
                    if(snapshot.hasData){
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
                          _audioPlayer.seekPosition(Duration(seconds: value.toInt()));
                          setState(() {
                            _time = value.toInt();
                          });
                        },
                      );
                    }else{
                      return Slider(
                        min: 0,
                        max: 0,
                        value: 0,
                      );
                    }
                  },
                ),
                // Tiempo en segundos
                Text('${Duration(seconds: _time).toString().substring(2, 7)}'),
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
              ),
              IconButton(
                onPressed: () => print('playlist_add'),
                icon: Icon(Icons.playlist_add),
              ),
            ],
          );
  }

  ButtonBar buildAudioControlls() {
    return ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(onPressed: () => print('Repeat'), icon: Icon(Icons.repeat_one), ),
              IconButton(onPressed: () => print('skip_previous'), icon: Icon(Icons.skip_previous), ),
              IconButton(onPressed: () {
                print('play_arrow');
                if(_playing){
                  _audioPlayer.pause();
                }else{
                  _audioPlayer.resume();
                }
                setState(() {
                  _playing = !_playing;
                });
              }, icon: Icon(_playing? Icons.pause : Icons.play_arrow), ),
              IconButton(onPressed: () => print('skip_next'), icon: Icon(Icons.skip_next), ),
              IconButton(onPressed: () => print('volume_up'), icon: Icon(Icons.volume_up), ),
            ],
          );
  }
}

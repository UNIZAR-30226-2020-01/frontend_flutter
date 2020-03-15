
import 'package:flutter_exoplayer/audioplayer.dart';

class PlayingSingleton{

  // Singleton atribute
  static final PlayingSingleton _instance = PlayingSingleton._internal();
  // Player atributes
  // TODO: Change this
  final String _url =
      'https://files.freemusicarchive.org/storage-freemusicarchive-org/music/no_curator/Yung_Kartz/August_2019/Yung_Kartz_-_04_-_One_Way.mp3';
  // Player
  AudioPlayer _audioPlayer = AudioPlayer();
  // Reproduction control
  // Para controlar el tiempo de la reproducción
  int _time;
  // Para controlar el estado de la reproduccion
  bool _playing;


  factory PlayingSingleton()=> _instance;

  PlayingSingleton._internal(){
    // Creacion del objeto aqui
    _audioPlayer.play(_url);
    _audioPlayer.stop();
    _time = 0;
    _playing = false;
    _audioPlayer.onAudioPositionChanged.listen((Duration d) => _time = d.inSeconds);
  }

  // Geters de la reproduccion
  get playing => _playing;
  get time => _time;
  get duration async => (await _audioPlayer.getDuration()).inSeconds;

  // Setters de valores especificos

  // Funciones de control de la reproduccion
  /// Reproduce el audio en la posicion dada.
  /// [position] in seconds
  void seekPosition(int position) async {
    _audioPlayer.seekPosition(Duration(seconds: position));
    _time = (await _audioPlayer.getCurrentPosition()).inSeconds;
  }

  /// Cambia el estado de la reproduccion de _playing a !_playing
  void changeReproductionState(){
    if(_playing){
      _audioPlayer.pause();
    }else{
      _audioPlayer.resume();
    }
    _playing = !_playing;
  }

/*  /// Aplica una funcion al metodo _audioPlayer.onAudioPositionChanged
  void onAudioPositionChanged(Function f){
    _audioPlayer.onAudioPositionChanged.listen(f);
  }*/

  Stream<Duration> getStreamedTime() => _audioPlayer.onAudioPositionChanged;

  // Funciones de representacion
  /// Devuelve una notación textual de la forma -> mm:ss, donde m son minutos y s segundos
  String toShortString() => toLongString().substring(2, 7);

  /// Devuelve una notación textual de la forma -> hh:mm:ss, donde h son horas, m son minutos y s segundos
  String toLongString() => Duration(seconds: _time).toString();
}
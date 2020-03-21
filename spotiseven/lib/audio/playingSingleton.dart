import 'dart:async';
import 'dart:convert';
import 'package:flutter_exoplayer/audioplayer.dart';
// Clase PlaylistController
import 'package:spotiseven/audio/playlistController.dart';
// Clase Playlist
import 'package:spotiseven/audio/utils/playlist.dart';
// Clase Song
import 'package:spotiseven/audio/utils/song.dart';

class PlayingSingleton {
  // Singleton attribute
  static final PlayingSingleton _instance = PlayingSingleton._internal();
  // Player attributes
  // TODO: Change this to playlist or something else
  final String _url =
      'https://files.freemusicarchive.org/storage-freemusicarchive-org/music/no_curator/Yung_Kartz/August_2019/Yung_Kartz_-_04_-_One_Way.mp3';
  // Player
  AudioPlayer _audioPlayer = AudioPlayer();
  // Reproduction control
  // Lista de reproduccion actual
  PlaylistController _playlistController;
  // Para controlar el tiempo de la reproducción
  int _time;
  // Para controlar el estado de la reproduccion
  bool _playing;

  factory PlayingSingleton() => _instance;

  // Suscripcion a evento de cambio de posicion
  StreamSubscription _subscriptionTime;

  PlayingSingleton._internal() {
    // Creacion del objeto aqui
    // TODO: El inicio de la reproduccion lo manda la playlist
//    _audioPlayer.play(_url);
//    _audioPlayer.stop();
    _time = 0;
    _playing = false;
    _subscriptionTime = _subscribeTime();
    // TODO: Cuando se acabe una cancion cambiar a la siguiente
//    _audioPlayer.onPlayerStateChanged.listen(() => );
    // Iniciamos el PlaylistController con una lista vacia (null)
    _playlistController = PlaylistController(null);
  }

  StreamSubscription<Duration> _subscribeTime() {
    return _audioPlayer.onAudioPositionChanged
        .listen((Duration d) => _time = d.inSeconds);
  }

  // Geters de la reproduccion
  get playing => _playing;
  get time => _time;
  get duration async => (await _audioPlayer.getDuration()).inSeconds;
  Playlist get playlist => _playlistController.actualPlaylist;
  Song get song => _playlistController.actualSong;

  // Setters de valores especificos

  // Setter de playlist a reproducir
  void setPlayList(Playlist p) {
    // Paramos cualquier cancion que estuviera reproduciendose
    _audioPlayer.stop();
    _playing = false;
    // Cambiamos el PlaylistController con la nueva lista de reproduccion
    _playlistController = PlaylistController(p);
    // Actualizamos la reproduccion
    play(_playlistController.actualSong);
  }

  // Funciones de control de la reproduccion

  /// Reproducir una nueva cancion
  Future<void> play(Song song) async {
    print('${song.url}');
    // Cancelamos todas las suscripciones
    _subscriptionTime.cancel();
    // Eliminamos el objeto
    _audioPlayer.dispose();
//    print('dispose1');
    // Creamos un nuevo objeto
    _audioPlayer = AudioPlayer();
    await _audioPlayer.play(song.url);
    // Volvemos a activar las suscripciones
    _subscriptionTime = _subscribeTime();

//    print('STATE: ${_audioPlayer.state.toString()}');
//    print('${(await _audioPlayer.getDuration()).inSeconds}');
    // Cambiamos al estado predeterminado
    _time = 0;
    _playing = true;
  }

  /// Reproducir la siguiente cancion
  Future<void> next() async {
    print('PLAYINGSINGLETON: Next Song');
    _audioPlayer.stop();
    _playing = false;
    _playlistController.next();
    print('${_playlistController.actualSong.title}');
    await play(_playlistController.actualSong);
  }

  /// Reproducir la cancion anterior
  Future<void> previous() async {
    print('PLAYINGSINGLETON: Previous Song');
    _audioPlayer.stop();
    _playing = false;
    _playlistController.previous();
    print('${_playlistController.actualSong.title}');
    await play(_playlistController.actualSong);
  }

  /// Reproduce el audio en la posicion dada.
  /// [position] in seconds
  void seekPosition(int position) async {
    _audioPlayer.seekPosition(Duration(seconds: position));
    _time = (await _audioPlayer.getCurrentPosition()).inSeconds;
  }

  /// Cambia el estado de la reproduccion de _playing a !_playing
  void changeReproductionState() {
    if (_playlistController.actualSong != null) {
      // Si no hay cancion actual -> No hay lista de reproduccion
      if (_playing) {
        _audioPlayer.pause();
      } else {
        _audioPlayer.resume();
      }
      _playing = !_playing;
    }
  }

  // TODO: Añadir a cola de reproduccion

/*  /// Aplica una funcion al metodo _audioPlayer.onAudioPositionChanged
  void onAudioPositionChanged(Function f){
    _audioPlayer.onAudioPositionChanged.listen(f);
  }*/

  /// Para permitir la actualizacion del slider del tiempo
  Stream<Duration> getStreamedTime() => _audioPlayer.onAudioPositionChanged;

  /// Para permitir el cambio del esado de reproduccion
  Stream<PlayerState> getStreamedPlayedState() =>
      _audioPlayer.onPlayerStateChanged;

  /// Para permitir la actualizacion de la duracion
  Stream<Duration> getStreamedDuration() => _audioPlayer.onDurationChanged;

  // Funciones de representacion
  /// Devuelve una notación textual de la forma -> mm:ss, donde m son minutos y s segundos
  String toShortString() => toLongString().substring(2, 7);

  /// Devuelve una notación textual de la forma -> hh:mm:ss, donde h son horas, m son minutos y s segundos
  String toLongString() => Duration(seconds: _time).toString();
}

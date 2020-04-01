import 'dart:async';
import 'package:flutter/cupertino.dart';
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
  // Player
  AudioPlayer _audioPlayer = AudioPlayer();
  // Reproduction control
  // Lista de reproduccion actual
  PlaylistController _playlistController;
  // Para controlar el tiempo de la reproducción
  int _time;
  // Para controlar el estado de la reproduccion
  bool _playing;

  // Para notificar los cambios de cancion
  StreamController _songNotifier;

  factory PlayingSingleton() => _instance;

  // Suscripcion a evento de cambio de posicion
  StreamSubscription _subscriptionTime;
  // Suscripcion a evento de final de cancion
  StreamSubscription _subscriptionFinal;

  PlayingSingleton._internal() {
    // Creacion del objeto aqui
    // Valores iniciales por defecto
    _time = 0;
    _playing = false;
    subscribeStreams();
    // Iniciamos el stream de notificacion
    _songNotifier = StreamController<Song>.broadcast();
    // Iniciamos el PlaylistController con una lista vacia (null)
    _playlistController = PlaylistController(null);
  }

  void subscribeStreams() {
    _subscriptionTime = _audioPlayer.onAudioPositionChanged
        .listen((Duration d) => _time = d.inSeconds);
    _subscriptionFinal =
        _audioPlayer.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.COMPLETED) {
        // Se ha completado la cancion. Pasamos a la siguiente.
        this.next();
      }
    });
  }

  Future<void> cancelStreams() async {
    _subscriptionTime.cancel();
    _subscriptionFinal.cancel();
  }

  // Geters de la reproduccion
  get playing => _playing;
  get time => _time;
  get duration async => (await _audioPlayer.getDuration()).inSeconds;
  Playlist get playlist => _playlistController.actualPlaylist;
  Song get song => _playlistController.actualSong;

  // Setters de valores especificos
  void randomize() {
    _playlistController.random();
  }

  // Setter de playlist a reproducir
  void setPlayList(Playlist p) {
    // Paramos cualquier cancion que estuviera reproduciendose
    _audioPlayer.stop();
    _playing = false;
    // Cambiamos el PlaylistController con la nueva lista de reproduccion
    _playlistController = PlaylistController(Playlist.copy(p));
    // Actualizamos la reproduccion
    _play(_playlistController.actualSong);
  }

  // Funciones de control de la reproduccion

  // Reorder de la playlist en reproduccion
  void reorderPlaylist(Song s, int newIndex) {
    Song actual = this.song;
    // Introducimos la Song <s> con -2 porque eliminaremos 2 elementos.
    // <actual> y <s> para reinsertarlos
    _playlistController.playlist = _playlistController.actualPlaylist.playlist
        .where((Song song) => s != song && song != actual)
        .toList()
          ..insert(
              newIndex > _playlistController.actualPlaylist.playlist.length - 2
                  ? _playlistController.actualPlaylist.playlist.length - 2
                  : newIndex,
              s)
          ..insert(0, actual);
    _playlistController.setIteratorOn(actual);
  }

  /// Reproducir una nueva cancion
  Future<void> play(Song song) async {
    _playlistController.setIteratorOn(song);
    _play(song);
  }

  /// Reproducir una nueva cancion (version interna)
  Future<void> _play(Song song) async {
    print('${song.url}');
    // Cancelamos todas las suscripciones
    cancelStreams();
    // Eliminamos el objeto
    _audioPlayer.dispose();
//    print('dispose1');
    // Creamos un nuevo objeto
    _audioPlayer = AudioPlayer();
    await _audioPlayer.play(song.url);
    // Volvemos a activar las suscripciones
    subscribeStreams();
//    print('STATE: ${_audioPlayer.state.toString()}');
//    print('${(await _audioPlayer.getDuration()).inSeconds}');
    // Añadimos la cancion al flujo
    _songNotifier.add(song);
    // Cambiamos al estado predeterminado
    _time = 0;
    _playing = true;
  }

  /// Reproducir la siguiente cancion
  Future<void> next() async {
    print('PLAYINGSINGLETON: Next Song');
    _audioPlayer.stop();
    _playing = false;
    //avanza iter a sig cancin
    _playlistController.next();
    print('${_playlistController.actualSong.title}');
    await _play(_playlistController.actualSong);
  }

  /// Reproducir la cancion anterior
  Future<void> previous() async {
    print('PLAYINGSINGLETON: Previous Song');
    _audioPlayer.stop();
    _playing = false;
    _playlistController.previous();
    print('${_playlistController.actualSong.title}');
    await _play(_playlistController.actualSong);
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

  /// Para permitir la actualizacion del slider del tiempo
  Stream<Duration> getStreamedTime() => _audioPlayer.onAudioPositionChanged;

  /// Para permitir el cambio del esado de reproduccion
  Stream<PlayerState> getStreamedPlayedState() =>
      _audioPlayer.onPlayerStateChanged;

  /// Para permitir la actualizacion de la duracion
  Stream<Duration> getStreamedDuration() => _audioPlayer.onDurationChanged;

  /// Para permitir el control de la cancion que se esta reproduciendo (NUNCA CAMBIA EL STREAM)
  Stream<Song> getStreamedSong() => _songNotifier.stream;

  // Funciones de representacion
  /// Devuelve una notación textual de la forma -> mm:ss, donde m son minutos y s segundos
  String toShortString() => toLongString().substring(2, 7);

  /// Devuelve una notación textual de la forma -> hh:mm:ss, donde h son horas, m son minutos y s segundos
  String toLongString() => Duration(seconds: _time).toString();
}
